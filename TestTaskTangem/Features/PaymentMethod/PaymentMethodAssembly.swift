//
//  PaymentMethodAssembly.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 26.11.2024.
//

import SwiftUI

final class PaymentMethodAssembly {
    
    func assemble(coordinator: PaymentMethodCoordinator) -> some View {
        PaymentMethodView(
            viewModel: PaymentMethodViewModelImpl(
                coordinator: coordinator,
                useCase: PaymentMethodUseCaseImpl()
            )
        )
    }
}
