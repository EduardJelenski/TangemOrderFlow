//
//  OrderSummaryView.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 23.11.2024.
//

import SwiftUI

struct MyView: View {
    var body: some View {
        Section {
            Text("Delivery address")
                .bold()
            Text("Address data entered on first screen")
        }
    }
}

struct OrderSummaryView: View {
    
    @Namespace var ns
    
    @State var isSmall = false
    @State var isAnotherSmall = false
    
    var body: some View {
        Group {
            if isSmall {
                small
                    .padding(.horizontal)
                    .transition(.no)
            } else if isAnotherSmall {
                another
                    .padding(.horizontal)
            } else {
                large
                    .transition(.no)
            }
        }
        .safeAreaInset(edge: .bottom) {
            NavigationLink("Complete order") {
//                PaymentOptionView(viewModel: PaymentOptionViewModelImpl())
            }
            .dsButton()
            .padding()
        }
        
        .navigationBarHidden(true)
    }
    
    @ViewBuilder
    var another: some View {
        CustomSection {
            Text("Payment Way")
                .bold()
                .matchedGeometryEffect(id: "2t", in: ns)
            TextField(
                "Selected payment method",
                text: .constant("Selected payment method"),
                prompt: Text("Switzerland, Zug, 12 Bitcoin St., Tangem LLC.")
            )
            .textFieldStyle(.roundedBorder)
            .matchedGeometryEffect(id: "2s", in: ns)
        }
        .onTapGesture {
            withAnimation {
                isAnotherSmall.toggle()
            }
        }
        .matchedGeometryEffect(id: "section1", in: ns)
        .transition(.no)
        .listRowSeparator(.hidden)
    }
    
    @ViewBuilder
    var small: some View {
        CustomSection {
            Text("Delivery address")
                .bold()
                .matchedGeometryEffect(id: "1t", in: ns)
            TextField(
                "Delivery address text field",
                text: .constant("Address data entered on first screen"),
                prompt: Text("Switzerland, Zug, 12 Bitcoin St., Tangem LLC.")
            )
            .textFieldStyle(.roundedBorder)
            .matchedGeometryEffect(id: "1s", in: ns)
        }
        .onTapGesture {
            withAnimation {
                isSmall.toggle()
            }
        }
        .matchedGeometryEffect(id: "section", in: ns)
        .transition(.no)
        .listRowSeparator(.hidden)
    }
    
    @ViewBuilder
    var large: some View {
        ScrollView {
            Text("Order summary")
                .font(.largeTitle)
                .bold()
                .padding(.vertical)
            CustomSection {
                Text("Delivery address")
                    .bold()
                    .matchedGeometryEffect(id: "1t", in: ns)
                Text("Address data entered on first screen")
                    .matchedGeometryEffect(id: "1s", in: ns)
            }
            .matchedGeometryEffect(id: "section", in: ns)
            .onTapGesture {
                withAnimation {
                    isSmall = true
                }
            }
            .listRowSeparator(.hidden)
            .padding(.horizontal)
            
            CustomSection {
                Text("Payment Way")
                    .bold()
                    .matchedGeometryEffect(id: "2t", in: ns)
                Text("Selected payment method")
                    .matchedGeometryEffect(id: "2s", in: ns)
            }
            .matchedGeometryEffect(id: "section1", in: ns)
            .onTapGesture {
                withAnimation {
                    isAnotherSmall = true
                }
            }
            .listRowSeparator(.hidden)
            .padding(.horizontal)
        }
        .background {
            Color.lightGray.ignoresSafeArea()//.matchedGeometryEffect(id: "bg", in: ns)
        }
    }
}

#Preview {
    NavigationStack {
        OrderSummaryView()
    }
    .navigationBarHidden(true)
}

extension ShapeStyle where Self == Color {
    
    static var lightGray: Color { Color(uiColor: .systemGray6) }
}
