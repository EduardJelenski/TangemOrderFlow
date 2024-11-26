//
//  TestTaskTangemApp.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 23.11.2024.
//

import SwiftUI

@main
struct TestTaskTangemApp: App {
    
    @StateObject var coordinator = OrderFlowCoordinator()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                EmptyView()
                    .navigationDestination(for: OrderFlowRoute.self) { route in
                        coordinator.build(route)
                    }
            }
            .onAppear {
                coordinator.start()
            }
        }
    }
}

final class PaymentOptionAssembly {
    
}

enum OrderFlowRoute: Hashable {
    case deliveryAddress
    case paymentOption
}

final class OrderFlowCoordinator: ObservableObject {
    
    private let paymentOptionAssembly = PaymentOptionAssembly()
    
    @Published var path = NavigationPath()

    func start() {
        path.append(OrderFlowRoute.paymentOption)
    }
}

extension OrderFlowCoordinator {
    func paymentOption() {
        path.append(OrderFlowRoute.paymentOption)
    }
    
    func build(_ r: OrderFlowRoute) -> some View {
        switch r {
        case .deliveryAddress:
            DeliveryAddressView(viewModel: DeliveryAddressViewModelImpl(coordinator: self))
        case .paymentOption:
            PaymentOptionView(viewModel: PaymentOptionViewModelImpl())
        }
    }
}
