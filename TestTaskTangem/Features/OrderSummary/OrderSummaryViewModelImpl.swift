//
//  OrderSummaryViewModelImpl.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 26.11.2024.
//

import Combine

final class OrderSummaryViewModelImpl: OrderSummaryViewModel {
    var installments: InstallmentAvailability = .unavailable
    
    @Published var deliveryAddress: String
    @Published var paymentWay: String
    @Published var installmentPeriod: String?
    
    let options = ["Cash", "Card", "Installment"]
    
    private let coordinator: OrderSummaryCoordinator
    
    init(
        coordinator: OrderSummaryCoordinator,
        deliveryAddress: String,
        paymentMethod: PaymentMethod
    ) {
        self.coordinator = coordinator
        self.deliveryAddress = deliveryAddress
        switch paymentMethod {
        case .oneTime(let name):
            paymentWay = name
        case .installment(let period):
            paymentWay = "Installment"
            installmentPeriod = period
        }
    }
    
    func completeOrder() {
        // orderUseCase.order(...)
    }
}
