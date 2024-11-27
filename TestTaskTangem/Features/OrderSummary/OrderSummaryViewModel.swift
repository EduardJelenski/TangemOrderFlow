//
//  OrderSummaryViewModel.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 26.11.2024.
//

import Combine

protocol OrderSummaryViewModel: ObservableObject {
    
    var deliveryAddress: String { get set }
    var paymentMethods: [String] { get }
    var selectedMethod: String { get set }
    var selectedPeriod: String? { get set }
    var areInstallmentPeriodsAvailable: Bool { get }
    var installmentPeriods: [String] { get }
    
    func completeOrder()
}
