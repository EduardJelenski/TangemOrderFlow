//
//  PaymentOptionAssembly.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 26.11.2024.
//

import SwiftUI

final class PaymentOptionAssembly {
    
    func assemble(coordinator: PaymentOptionCoordinator) -> some View {
        PaymentOptionView(viewModel: PaymentOptionViewModelImpl(coordinator: coordinator))
    }
}
