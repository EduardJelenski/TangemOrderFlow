//
//  DeliveryAddressView.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 23.11.2024.
//

import SwiftUI

struct DeliveryAddressView<ViewModel: DeliveryAddressViewModel>: View {
    
    @StateObject var viewModel: ViewModel
    @FocusState var isFocused: Bool
    
    var body: some View {
        ScrollView {
            addressSection
                .padding(.top)
        }
        .onTapGesture {
            isFocused = false
        }
        .background(.lightGray)
        .safeAreaInset(edge: .bottom) {
            bottomButton
                .padding(.horizontal)
        }
        .navigationBarHidden(true)
    }
    
    private var bottomButton: some View {
        Button {
            viewModel.tap()
        } label: {
            Text("Continue")
                .dsButton()
        }
    }
    
    private var addressSection: some View {
        DSCustomSection {
            DeliveryAddressIsland(text: $viewModel.address)
                .focused($isFocused)
        }
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack {
        DeliveryAddressView(viewModel: DeliveryAddressViewModelImpl(coordinator: OrderFlowCoordinator()))
    }
}
