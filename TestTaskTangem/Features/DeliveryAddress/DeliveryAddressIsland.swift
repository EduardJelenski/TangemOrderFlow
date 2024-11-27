//
//  DeliveryAddressIsland.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 26.11.2024.
//

import SwiftUI

struct DeliveryAddressIsland: View {
    
    @Binding var text: String
    
    var body: some View {
        DSTitledContent("Delivery Address") {
            TextField(
                "Delivery Address",
                text: $text,
                prompt: Text("Switzerland, Zug, 12 Bitcoin St., Tangem LLC.")
            )
        }
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



