//
//  PaymentMethodRepositoryImpl.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 26.11.2024.
//

final class PaymentMethodRepositoryImpl: PaymentMethodUseCase {
    func fetchPaymentMethods() async throws -> [PaymentMethod] {
        [
            .oneTime(name: "Cash"),
            .oneTime(name: "Card"),
            .oneTime(name: "Installment")
        ]
    }
}
