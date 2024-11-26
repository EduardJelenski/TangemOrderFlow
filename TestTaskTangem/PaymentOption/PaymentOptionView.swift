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
                    Text("Payment Way")
                        .bold()
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
                        Text("Installment Period")
                            .bold()
                            .listRowSeparator(.hidden)
                    }
                }
            }
        }
        .pickerStyle(.inline)
        .safeAreaInset(edge: .bottom) {
            NavigationLink {
                OrderSummaryView()
            } label: {
                Text("Continue")
                    .dsButton()
                    .padding(.horizontal)
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    NavigationStack {
        PaymentOptionView(viewModel: PaymentOptionViewModelImpl())
    }
}
