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
        [3, 6, 9].map { String(localized: "\($0) months") }
    }
}
