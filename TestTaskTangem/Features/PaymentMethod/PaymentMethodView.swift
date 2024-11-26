//
//  PaymentMethodView.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 23.11.2024.
//

import SwiftUI

struct PaymentMethodView<ViewModel: PaymentMethodViewModel>: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        List {
            Section {
                Picker(selection: $viewModel.selectedMethod.animation()) {
                    ForEach(viewModel.methods, id: \.self) {
                        Text($0).tag(Optional($0))
                    }
                } label: {
                    DSTitle("Payment Way")
                        .listRowSeparator(.hidden)
                }
            }
            if case .available(let periods) = viewModel.installments {
                Section {
                    Picker(selection: $viewModel.selectedInstallment) {
                        ForEach(periods, id: \.self) {
                            Text($0).tag(Optional($0))
                        }
                    } label: {
                        DSTitle("Installment Period")
                            .listRowSeparator(.hidden)
                    }
                }
            }
        }
        .pickerStyle(.inline)
        .bottomButtonAction("Continue") {
            viewModel.didTapBottomButton()
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    NavigationStack {
        PaymentMethodView(viewModel: MockViewModel())
    }
}

private final class MockViewModel: PaymentMethodViewModel {
    var methods: [String] = ["Cash", "Card", "Installments"]
    
    var installments: InstallmentAvailability = .unavailable
    
    var selectedMethod: String?
    
    var selectedInstallment: String?
    
    func didTapBottomButton() {}
}
