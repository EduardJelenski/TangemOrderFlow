//
//  PaymentOptionView.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 23.11.2024.
//

import SwiftUI

enum InstallmentAvailability {
    case available(periods: [String])
    case unavailable
}

protocol PaymentOptionViewModel: ObservableObject {
    var options: [String] { get }
    var installments: InstallmentAvailability { get }
    
    var selectedOption: String? { get set }
    var selectedInstallment: String? { get set }
}

import Combine

final class PaymentOptionViewModelImpl: PaymentOptionViewModel {
    
    enum Constants {
        static let installmentOption = "Installment"
        static let installments = [3, 6, 9].map { "\($0) months" }
    }

    let options = ["Cash", "Card", Constants.installmentOption]
    @Published var installments: InstallmentAvailability = .unavailable
    
    @Published var selectedOption: String?
    @Published var selectedInstallment: String?
    
    init() {
        $selectedOption
            .map { option in
                option == Constants.installmentOption ? .available(periods: Constants.installments) : .unavailable
            }
            .assign(to: &$installments)
    }
}

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
            NavigationLink("Continue") {
                OrderSummaryView()
            }
            .dsButton()
            .padding()
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    NavigationStack {
        PaymentOptionView(viewModel: PaymentOptionViewModelImpl())
    }
}
