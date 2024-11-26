//
//  PaymentMethodViewModelImpl.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 26.11.2024.
//

import Combine

final class PaymentMethodViewModelImpl: PaymentMethodViewModel {
    enum Constants {
        static let installmentOption = "Installment"
        static let installments = [3, 6, 9].map { "\($0) months" }
    }

    let methods = ["Cash", "Card", Constants.installmentOption]
    @Published var installments: InstallmentAvailability = .unavailable
    
    @Published var selectedMethod: String?
    @Published var selectedInstallment: String?
    
    private let coordinator: PaymentMethodCoordinator
    
    init(coordinator: PaymentMethodCoordinator) {
        self.coordinator = coordinator
        subscribeOnSelectedOption()
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
    
    private func subscribeOnSelectedOption() {
        $selectedMethod
            .map { method in
                method == Constants.installmentOption ? .available(periods: Constants.installments) : .unavailable
            }
            .assign(to: &$installments)
    }
}
