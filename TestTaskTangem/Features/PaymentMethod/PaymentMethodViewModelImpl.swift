//
//  PaymentMethodViewModelImpl.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 26.11.2024.
//

import Combine

final class PaymentMethodViewModelImpl: PaymentMethodViewModel {
    enum Constants {
        static let installmentMethod = "Installment"
    }

    let methods: [String]
    @Published var installmentPeriods: [String]? = nil
    
    @Published var selectedMethod: String?
    @Published var selectedInstallment: String?
    
    private let useCase: PaymentMethodUseCase
    private let coordinator: PaymentMethodCoordinator
    
    init(coordinator: PaymentMethodCoordinator, useCase: PaymentMethodUseCase) {
        self.coordinator = coordinator
        self.useCase = useCase
        methods = useCase.paymentMethods()
        subscribeOnSelectedMethod()
    }
    
    func didTapBottomButton() {
        if let selectedMethod {
            if let selectedInstallment {
                coordinator.orderSummary(outputting: .installment(period: selectedInstallment))
            } else {
                coordinator.orderSummary(outputting: .oneTime(name: selectedMethod))
            }
        } else {
            // TODO: display error state
        }
        
    }
    
    private func subscribeOnSelectedMethod() {
        $selectedMethod
            .map { method in // CHECK RETAIN
                method == Constants.installmentMethod ? self.useCase.installmentPeriods() : nil
            }
            .assign(to: &$installmentPeriods)
    }
}
