//
//  OrderSummaryViewModelImpl.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 26.11.2024.
//

import Combine

final class OrderSummaryViewModelImpl: OrderSummaryViewModel {

    @Published var deliveryAddress: String
    @Published var paymentWay: String
    @Published var installmentPeriod: String?
    @Published var areInstallmentPeriodsAvailable: Bool
    let installmentPeriods: [String]
    let paymentMethods: [String]
    
    private let useCase: PaymentMethodUseCase
    private let coordinator: OrderSummaryCoordinator
    
    init(
        coordinator: OrderSummaryCoordinator,
        useCase: PaymentMethodUseCase,
        deliveryAddress: String,
        paymentMethod: PaymentMethod
    ) {
        self.coordinator = coordinator
        self.deliveryAddress = deliveryAddress
        self.useCase = useCase
        paymentMethods = useCase.paymentMethods()
        installmentPeriods = useCase.installmentPeriods()
        
        switch paymentMethod {
        case .oneTime(let name):
            paymentWay = name
            areInstallmentPeriodsAvailable = false
        case .installment(let period):
            paymentWay = "Installment"
            installmentPeriod = period
            areInstallmentPeriodsAvailable = true
        }
        
        subscribeOnPaymentMethod()
    }
    
    private func subscribeOnPaymentMethod() {
        $paymentWay
            .map { $0 == "Installment" }
            .assign(to: &$areInstallmentPeriodsAvailable)
        
        $paymentWay
            .filter { $0 != "Installment" }
            .map { _ in nil }
            .assign(to: &$installmentPeriod)
    }
    
    func completeOrder() {
        // orderUseCase.order(...)
    }
}
