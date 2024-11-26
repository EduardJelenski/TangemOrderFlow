//
//  DeliveryAddressAssembly.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 26.11.2024.
//

import SwiftUI

final class DeliveryAddressAssembly {
    
    func assemble(coordinator: DeliveryAddressCoordinator) -> some View {
        DeliveryAddressView(viewModel: DeliveryAddressViewModelImpl(coordinator: coordinator))
    }
}
