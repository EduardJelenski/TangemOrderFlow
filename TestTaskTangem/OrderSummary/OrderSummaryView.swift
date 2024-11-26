//
//  OrderSummaryView.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 23.11.2024.
//

import SwiftUI



enum SummaryTransition {
    case deliveryAddress
    case paymentWay
}

struct OrderSummaryView: View {
    
    @StateObject var viewModel = OrderSummaryViewModelImpl()
    
    @Namespace var namespace
    
    @FocusState var editedField: SummaryTransition?
    
    @State var transition: SummaryTransition?
    
    var body: some View {
        Group {
            switch transition {
            case nil:
                ScrollView {
                    mainView
                }
                .padding(.horizontal)
            case .deliveryAddress:
                ScrollView {
                    deliveryAddress
                }
                .padding(.horizontal)
            case .paymentWay:
                paymentWay
            }
        }
        .background(.lightGray)
        .onTapGesture {
            withAnimation {
                transition = nil
            }
            editedField = nil
        }
        .safeAreaInset(edge: .bottom) {
            Button("Complete order") {
                
            }
            .dsButton()
            .padding()
        }
        .navigationBarHidden(true)
    }
    
    enum AnimationID {
        static let deliveryAddress = "deliveryAddress"
        static let paymentWay = "paymentWay"
    }
    
    @ViewBuilder
    var mainView: some View {
        title
            .padding(.vertical)
        DSCustomSection {
            DSTitledContent("Delivery address") {
                Text(viewModel.address)
            }
        }
        .matchedGeometryEffect(id: AnimationID.deliveryAddress, in: namespace)
        .onTapGesture {
            withAnimation {
                transition = .deliveryAddress
            }
            editedField = .deliveryAddress
        }
        
        DSCustomSection {
            DSTitledContent("Payment Way") {
                Text(viewModel.paymentWay)
            }
        }
        .matchedGeometryEffect(id: AnimationID.paymentWay, in: namespace)
        .onTapGesture {
            withAnimation {
                transition = .paymentWay
            }
            editedField = .paymentWay
        }
    }
    
    var deliveryAddress: some View {
        DSCustomSection {
            DeliveryAddressIsland(text: $viewModel.address)
                .focused($editedField, equals: .deliveryAddress)
        }
        .matchedGeometryEffect(id: AnimationID.deliveryAddress, in: namespace)
    }
    
    var paymentWay: some View {
        VStack {
            Picker(selection: $viewModel.paymentWay) {
                ForEach(viewModel.options, id: \.self) {
                    Text($0).tag($0)
                }
            } label: {
                Text("Payment Way")
                    .bold()
            }
            .pickerStyle(.wheel)
            Spacer()
        }
        .matchedGeometryEffect(id: AnimationID.paymentWay, in: namespace)
    }
    
    var title: some View {
        Text("Order summary")
            .font(.largeTitle)
            .bold()
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

