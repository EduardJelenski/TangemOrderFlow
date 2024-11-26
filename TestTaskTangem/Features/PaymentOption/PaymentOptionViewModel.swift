//
//  PaymentOptionViewModel.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 26.11.2024.
//

import Combine

enum InstallmentAvailability: Hashable {
    case available(periods: [String])
    case unavailable
}

protocol PaymentOptionViewModel: ObservableObject {
    var options: [String] { get }
    var installments: InstallmentAvailability { get }
    
    var selectedOption: String? { get set }
    var selectedInstallment: String? { get set }
    
    func didTapBottomButton()
}
