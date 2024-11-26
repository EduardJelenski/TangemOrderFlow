//
//  OrderFlowCoordinator.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 26.11.2024.
//

import SwiftUI

enum OrderFlowRoute: Hashable {
    case deliveryAddress
    case paymentOption
    case orderSummary
}

enum PaymentMethod {
    case oneTime(name: String)
    case installment(period: String)
}

final class OrderFlowCoordinator: ObservableObject {
    
    private struct OrderFlowStorage {
        var deliveryAddress: String? = nil
        var paymentMethod: PaymentMethod? = nil
    }

    @Published var path = NavigationPath()
    
    private let orderSummaryAssembly = OrderSummaryAssembly()
    private let paymentOptionAssembly = PaymentOptionAssembly()
    private let deliveryAddressAssembly = DeliveryAddressAssembly()
    
    private var flowStorage = OrderFlowStorage()
    
    @ViewBuilder
    func build(_ route: OrderFlowRoute) -> some View {
        switch route {
        case .deliveryAddress:
            deliveryAddressAssembly.assemble(coordinator: self)
        case .paymentOption:
            paymentOptionAssembly.assemble(coordinator: self)
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
    func paymentOption(outputting address: String) {
        flowStorage.deliveryAddress = address
        path.append(OrderFlowRoute.paymentOption)
    }
}

extension OrderFlowCoordinator: PaymentOptionCoordinator {
    func orderSummary(outputting paymentMethod: PaymentMethod) {
        flowStorage.paymentMethod = paymentMethod
        path.append(OrderFlowRoute.orderSummary)
    }
}

extension OrderFlowCoordinator: OrderSummaryCoordinator {}
