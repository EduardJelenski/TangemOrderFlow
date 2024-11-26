//
//  DeliveryAddressViewModelImpl.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 26.11.2024.
//

import Combine

final class DeliveryAddressViewModelImpl: DeliveryAddressViewModel {
    
    @Published var address = ""
    @Published private(set) var isErrored = false
    
    private let coordinator: DeliveryAddressCoordinator
    
    private var cancellables = Set<AnyCancellable>()
    
    init(coordinator: DeliveryAddressCoordinator) {
        self.coordinator = coordinator
        subscribeOnAddress()
    }
    
    func didTapContinue() {
        if validateAddress() {
            coordinator.paymentOption(outputting: address)
        } else {
            isErrored = true
        }
    }
    
    private func subscribeOnAddress() {
        $address
            .map { _ in false }
            .assign(to: &$isErrored)
    }
    
    private func validateAddress() -> Bool {
        // addressValidationUseCase.validateAddress(...)
        !address.isEmpty
    }
}
