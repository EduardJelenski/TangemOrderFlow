//
//  OrderSummaryAssembly.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 26.11.2024.
//

import SwiftUI

struct OrderSummaryAssemblyInput {
    let deliveryAddress: String
    let paymentMethod: PaymentMethod
}

final class OrderSummaryAssembly {
    func assemble(coordinator: OrderSummaryCoordinator, input: OrderSummaryAssemblyInput) -> some View {
        let viewModel = OrderSummaryViewModelImpl(
            coordinator: coordinator,
            deliveryAddress: input.deliveryAddress,
            paymentMethod: input.paymentMethod
        )
        return OrderSummaryView(viewModel: viewModel)
    }
}
