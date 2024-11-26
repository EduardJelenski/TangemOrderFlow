//
//  PaymentOptionView.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 23.11.2024.
//

import SwiftUI

struct PaymentOptionView<ViewModel: PaymentOptionViewModel>: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        List {
            Section {
                Picker(selection: $viewModel.selectedOption.animation()) {
                    ForEach(viewModel.options, id: \.self) {
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
        PaymentOptionView(viewModel: MockViewModel())
    }
}

private final class MockViewModel: PaymentOptionViewModel {
    var options: [String] = ["Cash", "Card", "Installments"]
    
    var installments: InstallmentAvailability = .unavailable
    
    var selectedOption: String?
    
    var selectedInstallment: String?
    
    func didTapBottomButton() {}
}
