//
//  DeliveryAddressViewModel.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 26.11.2024.
//

import Combine

protocol DeliveryAddressViewModel: ObservableObject {
    var address: String { get set }
    var isErrored: Bool { get }
    
    func didTapContinue()
}
