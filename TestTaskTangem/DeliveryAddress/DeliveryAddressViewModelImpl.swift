//
//  DeliveryAddressViewModelImpl.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 26.11.2024.
//

import Combine

final class DeliveryAddressViewModelImpl: DeliveryAddressViewModel {
    
    private let coordinator: OrderFlowCoordinator
    
    @Published var address = ""
    
    init(coordinator: OrderFlowCoordinator) {
        self.coordinator = coordinator
    }
    
    func tap() {
        coordinator.paymentOption()
    }
}
