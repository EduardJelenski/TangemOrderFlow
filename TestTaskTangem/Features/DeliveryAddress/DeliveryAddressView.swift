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
            if viewModel.isErrored {
                DSCaption(title: "Address is invalid")
                    .foregroundStyle(.red)
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .animation(.bouncy, value: viewModel.isErrored)
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack {
        DeliveryAddressView(viewModel: MockViewModel())
    }
}

private final class MockViewModel: DeliveryAddressViewModel {
    @Published var address: String = ""
    @Published var isErrored: Bool = false

    func didTapContinue() {}
}
