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
        .background(.lightGray)
        .onTapGesture {
            isFocused = false
        }
        .bottomButtonAction("Continue") {
            viewModel.didTapContinue()
        }
        .navigationBarHidden(true)
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
