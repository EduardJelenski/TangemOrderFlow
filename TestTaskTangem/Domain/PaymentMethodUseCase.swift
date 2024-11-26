//
//  PaymentMethodUseCase.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 26.11.2024.
//

protocol PaymentMethodUseCase {
    func fetchPaymentMethods() async throws -> [PaymentMethod]
}
