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
                coordinator.build(.deliveryAddress)
                    .navigationDestination(for: OrderFlowRoute.self) { route in
                        coordinator.build(route)
                    }
            }
        }
    }
}

