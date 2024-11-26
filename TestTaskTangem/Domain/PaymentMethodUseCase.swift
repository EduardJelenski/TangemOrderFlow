//
//  PaymentMethodUseCase.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 26.11.2024.
//

protocol PaymentMethodUseCase {
    func paymentMethods() -> [String]
    func installmentPeriods() -> [String]
}
