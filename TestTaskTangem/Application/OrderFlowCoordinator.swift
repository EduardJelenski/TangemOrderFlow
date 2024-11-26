//
//  OrderFlowCoordinator.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 26.11.2024.
//

import SwiftUI

enum OrderFlowRoute: Hashable {
    case deliveryAddress
    case paymentMethod
    case orderSummary
}

final class OrderFlowCoordinator: ObservableObject {
    
    private struct OrderFlowStorage {
        var deliveryAddress: String? = nil
        var paymentMethod: PaymentMethod? = nil
    }

    @Published var path = NavigationPath()
    
    private let orderSummaryAssembly = OrderSummaryAssembly()
    private let paymentMethodAssembly = PaymentMethodAssembly()
    private let deliveryAddressAssembly = DeliveryAddressAssembly()
    
    private var flowStorage = OrderFlowStorage()
    
    @ViewBuilder
    func build(_ route: OrderFlowRoute) -> some View {
        switch route {
        case .deliveryAddress:
            deliveryAddressAssembly.assemble(coordinator: self)
        case .paymentMethod:
            paymentMethodAssembly.assemble(coordinator: self)
        case .orderSummary:
            buildOrderSummary()
        }
    }
    
    @ViewBuilder
    private func buildOrderSummary() -> some View {
        if
            let deliveryAddress = flowStorage.deliveryAddress,
            let paymentMethod = flowStorage.paymentMethod
        {
            let input = OrderSummaryAssemblyInput(
                deliveryAddress: deliveryAddress,
                paymentMethod: paymentMethod
            )
            orderSummaryAssembly.assemble(coordinator: self, input: input)
        } else {
            // logger.log("Unable to build OrderSummary")
            EmptyView()
        }
    }
}

extension OrderFlowCoordinator: DeliveryAddressCoordinator {
    func paymentMethod(outputting address: String) {
        flowStorage.deliveryAddress = address
        path.append(OrderFlowRoute.paymentMethod)
    }
}

extension OrderFlowCoordinator: PaymentMethodCoordinator {
    func orderSummary(outputting paymentMethod: PaymentMethod) {
        flowStorage.paymentMethod = paymentMethod
        path.append(OrderFlowRoute.orderSummary)
    }
}

extension OrderFlowCoordinator: OrderSummaryCoordinator {}
