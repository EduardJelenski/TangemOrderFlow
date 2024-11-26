//
//  PaymentMethodViewModel.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 26.11.2024.
//

import Combine

protocol PaymentMethodViewModel: ObservableObject {
    var methods: [String] { get }
    var installmentPeriods: [String]? { get }
    
    var selectedMethod: String? { get set }
    var selectedInstallment: String? { get set }
    
    func didTapBottomButton()
}
