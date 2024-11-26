//
//  PaymentMethodViewModel.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 26.11.2024.
//

import Combine

enum InstallmentAvailability: Hashable {
    case available(periods: [String])
    case unavailable
}

protocol PaymentMethodViewModel: ObservableObject {
    var methods: [String] { get }
    var installments: InstallmentAvailability { get }
    
    var selectedMethod: String? { get set }
    var selectedInstallment: String? { get set }
    
    func didTapBottomButton()
}
