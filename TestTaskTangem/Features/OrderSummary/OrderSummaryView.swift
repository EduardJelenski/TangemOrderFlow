//
//  OrderSummaryView.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 23.11.2024.
//

import SwiftUI

private enum SummaryTransition {
    case deliveryAddress
    case paymentWay
}

private enum AnimationID {
    static let deliveryAddress = "deliveryAddress"
    static let paymentWay = "paymentWay"
}

struct OrderSummaryView<ViewModel: OrderSummaryViewModel>: View {
    
    @StateObject var viewModel: ViewModel
    
    @FocusState private var editedField: SummaryTransition?
    @State private var transition: SummaryTransition?
    @Namespace private var namespace
    
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
        .bottomButtonAction("Complete order") {
            viewModel.completeOrder()
        }
        .navigationBarHidden(true)
    }
    
    @ViewBuilder
    var mainView: some View {
        title
            .padding(.vertical)
        DSCustomSection {
            DSTitledContent("Delivery address") {
                Text(viewModel.deliveryAddress)
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
            DeliveryAddressIsland(text: $viewModel.deliveryAddress)
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
        OrderSummaryView(viewModel: MockViewModel())
    }
    .navigationBarHidden(true)
}

private final class MockViewModel: OrderSummaryViewModel {
    @Published var installmentPeriod: String? = ""

    @Published var deliveryAddress = ""
    
    @Published var paymentWay = ""
    
    @Published var options = ["Cash", "Card", "Installment"]
    
    func completeOrder() {
        
    }
}
