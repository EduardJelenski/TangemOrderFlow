//
//  OrderSummaryViewModelImpl.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 26.11.2024.
//

import Combine

final class OrderSummaryViewModelImpl: OrderSummaryViewModel {
    
    private enum Constants {
        static let installment = "Installment"
    }

    @Published var deliveryAddress: String
    
    @Published var selectedMethod: String
    let paymentMethods: [String]
    
    @Published private(set) var areInstallmentPeriodsAvailable: Bool
    @Published var selectedPeriod: String?
    let installmentPeriods: [String]
    
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
            self.selectedMethod = name
            areInstallmentPeriodsAvailable = false
        case .installment(let period):
            self.selectedMethod = Constants.installment
            selectedPeriod = period
            areInstallmentPeriodsAvailable = true
        }
        
        updateInstallmentPeriodsAvailabilityOnPaymentMethodChange()
        updateInstallmentPeriodOnPaymentMethodChange()
    }
    
    private func updateInstallmentPeriodsAvailabilityOnPaymentMethodChange() {
        $selectedMethod
            .map { $0 == Constants.installment }
            .assign(to: &$areInstallmentPeriodsAvailable)
    }
    
    private func updateInstallmentPeriodOnPaymentMethodChange() {
        $selectedMethod
            .filter { $0 != Constants.installment }
            .map { _ in nil }
            .assign(to: &$selectedPeriod)
    }
    
    func completeOrder() {
        // orderUseCase.order(...)
    }
}
