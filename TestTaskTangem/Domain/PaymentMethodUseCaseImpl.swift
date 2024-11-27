//
//  PaymentMethodRepositoryImpl.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 26.11.2024.
//

final class PaymentMethodUseCaseImpl: PaymentMethodUseCase {
    func paymentMethods() -> [String] {
        [
            String(localized: "Cash"),
            String(localized: "Card"),
            String(localized: "Installment")
        ]
    }
    
    func installmentPeriods() -> [String] {
        [1, 3, 6].map { String(localized: "\($0) months") }
    }
}
