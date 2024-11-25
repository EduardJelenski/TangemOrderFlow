//
//  DelAdr.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 23.11.2024.
//

import SwiftUI

struct DelAdr: View {
    
    var ns: Namespace.ID
    
    @State var address = ""
    @FocusState var focused: Bool
    
    var body: some View {
        List {
            Section {
                Text("Delivery address")
                    .bold()
                TextField(
                    "Delivery address text field",
                    text: $address,
                    prompt: Text("Switzerland, Zug, 12 Bitcoin St., Tangem LLC.")
                )
                .focused($focused)
            }
            .listRowSeparator(.hidden)
            
        }
        .onTapGesture {
            focused = false
        }
        .background(.lightGray)
        .safeAreaInset(edge: .bottom) {
            NavigationLink("Continue") {
                PaymentOptionView()
            }
            .dsButton()
            .padding()
        }
        .navigationBarHidden(true)
    }
}
