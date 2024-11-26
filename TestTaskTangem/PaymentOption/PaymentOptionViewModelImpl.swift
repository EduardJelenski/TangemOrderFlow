//
//  PaymentOptionViewModelImpl.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 26.11.2024.
//

import Combine

final class PaymentOptionViewModelImpl: PaymentOptionViewModel {
    
    enum Constants {
        static let installmentOption = "Installment"
        static let installments = [3, 6, 9].map { "\($0) months" }
    }

    let options = ["Cash", "Card", Constants.installmentOption]
    @Published var installments: InstallmentAvailability = .unavailable
    
    @Published var selectedOption: String?
    @Published var selectedInstallment: String?
    
    init() {
        $selectedOption
            .map { option in
                option == Constants.installmentOption ? .available(periods: Constants.installments) : .unavailable
            }
            .assign(to: &$installments)
    }
}
