//
//  DeliveryAddressView.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 23.11.2024.
//

import SwiftUI

struct DeliveryAddressView: View {
    
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

#Preview {
    NavigationStack {
        DeliveryAddressView()
    }
}

struct MyModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.quaternary, in: Capsule())
    }
}

extension View {
    func dsButton() -> some View {
        self
            .bold()
            .foregroundStyle(.black)
            .padding()
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(15)
        
    }
}

struct Card<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            content
        }
        .padding()
        .background(.white)
        .cornerRadius(10)
    }
}


