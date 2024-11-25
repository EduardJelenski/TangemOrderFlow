//
//  PaymentOptionView.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 23.11.2024.
//

import SwiftUI

let options = ["PayPal", "Card", "Installment"]
let installments = [3, 6, 9].map { "\($0) months" }

extension String: @retroactive Identifiable {
    public var id: String { self }
}

struct PaymentOptionView: View {
    
    @State var paymentOption: String? = options[2]
    @State var installmentOption: String? = options[0]
    
//    @State private var selection: Reaction? = .none
    
    var body: some View {
            
        List {
            Section {
                Text("Payment Way")
                    .bold()
                    .listRowSeparator(.hidden)
                
                    Picker("Hello", selection: $paymentOption) {
                        ForEach(options) {
                            Text($0).tag(Optional($0))
                        }
                    }
                    .pickerStyle(.inline)
            }
            
            
            if paymentOption == "Installment" {
                Section {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Installment type")
                            .bold()
                    }
                    .listRowSeparator(.hidden)
                    
                    
                    Picker("", selection: $installmentOption) {
                        ForEach(installments) {
                            Text($0).tag(Optional($0))
                        }
                    }
                    .pickerStyle(.inline)
                }
            }
            
        }
        .labelsHidden()
        .animation(.default, value: paymentOption == "Installment")
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
    
    PaymentOptionView()
}

