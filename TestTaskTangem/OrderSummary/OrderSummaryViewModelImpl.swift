//
//  OrderSummaryViewModelImpl.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 26.11.2024.
//

import Combine

final class OrderSummaryViewModelImpl: ObservableObject, PaymentOptionViewModel {
    var installments: InstallmentAvailability = .unavailable
    
    @Published var selectedOption: String?
    
    @Published var selectedInstallment: String?
    
    @Published var address = "Pushkinskaya"
    
    @Published var paymentWay = "MIRCARD"
    
    let options = ["Cash", "Card", "Installment"]
}
