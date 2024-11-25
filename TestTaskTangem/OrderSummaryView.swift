//
//  OrderSummaryView.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 23.11.2024.
//

import SwiftUI

final class OrderSummaryViewModelImpl: ObservableObject {
    @Published var address = "Pushkinskaya"
    
    @Published var paymentWay = "MIRCARD"
}

enum SummaryTransition {
    case deliveryAddress
    case paymentWay
}

struct OrderSummaryView: View {
    
    @StateObject var viewModel = OrderSummaryViewModelImpl()
    
    @Namespace var namespace
    
    @FocusState var editedField: SummaryTransition?
    
    @State var transition: SummaryTransition?// = .deliveryAddress
    
    var body: some View {
        ScrollView {
            Group {
                switch transition {
                case nil:
                    mainView
                case .deliveryAddress:
                    deliveryAddress
                case .paymentWay:
                    paymentWay
                }
            }
            .padding(.horizontal)
        }
        .onTapGesture {
            withAnimation {
                transition = nil
                editedField = nil
            }
        }
        .background(.lightGray)
        .safeAreaInset(edge: .bottom) {
            Button("Complete order") {
                
            }
            .dsButton()
            .padding()
        }
        .navigationBarHidden(true)
    }
    
    @ViewBuilder
    var mainView: some View {
        Text("Order summary")
            .font(.largeTitle)
            .bold()
            .padding(.vertical)
        CustomSection {
            TitledContent("Delivery address") {
                Text(viewModel.address)
            }
        }
        .matchedGeometryEffect(id: "section", in: namespace)
        .onTapGesture {
            withAnimation {
                transition = .deliveryAddress
                editedField = .deliveryAddress
            }
        }
        
        CustomSection {
            TitledContent("Payment Way") {
                Text(viewModel.paymentWay)
            }
        }
        .matchedGeometryEffect(id: "section1", in: namespace)
        .onTapGesture {
            withAnimation {
                transition = .paymentWay
                editedField = .paymentWay
            }
        }
    }
    
    var deliveryAddress: some View {
        CustomSection {
            TitledContent("Delivery address") {
                TextField(
                    "Delivery Address",
                    text: $viewModel.address,
                    prompt: Text("Switzerland, Zug, 12 Bitcoin St., Tangem LLC.")
                )
                .focused($editedField, equals: .deliveryAddress)
            }
        }
        .matchedGeometryEffect(id: "section", in: namespace)
    }
    
    var paymentWay: some View {
        CustomSection {
            TitledContent("Payment Way") {
                TextField(
                    "Selected payment method",
                    text: .constant("Selected payment method"),
                    prompt: Text("Switzerland, Zug, 12 Bitcoin St., Tangem LLC.")
                )
                .focused($editedField, equals: .paymentWay)
            }
        }
        .matchedGeometryEffect(id: "section1", in: namespace)
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
