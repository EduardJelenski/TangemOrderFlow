//
//  DeliveryAddressViewModelImpl.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 26.11.2024.
//

import Combine

final class DeliveryAddressViewModelImpl: DeliveryAddressViewModel {
    
    private let coordinator: DeliveryAddressCoordinator
    
    @Published var address = ""
    
    init(coordinator: DeliveryAddressCoordinator) {
        self.coordinator = coordinator
    }
    
    func didTapContinue() {
        // TODO: Validate address
        coordinator.paymentOption(outputting: address)
    }
}
