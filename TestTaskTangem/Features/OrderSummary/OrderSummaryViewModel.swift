//
//  OrderSummaryViewModel.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 26.11.2024.
//

import Combine

protocol OrderSummaryViewModel: ObservableObject {
    
    var deliveryAddress: String { get set }
    var paymentWay: String { get set }
    var installmentPeriod: String? { get set }
    var options: [String] { get }
    
    func completeOrder()
}
