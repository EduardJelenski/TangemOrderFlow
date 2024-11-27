//
//  OrderSummaryView.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 23.11.2024.
//

import SwiftUI

private enum SummaryTransition {
    case deliveryAddress
    case paymentMethod
}

private enum AnimationID {
    static let deliveryAddress = "deliveryAddress"
    static let paymentMethod = "paymentMethod"
}

struct OrderSummaryView<ViewModel: OrderSummaryViewModel>: View {
    
    @StateObject var viewModel: ViewModel
    
    @FocusState private var editedField: SummaryTransition?
    @State private var transition: SummaryTransition?
    @Namespace private var namespace
    
    var body: some View {
        ScrollView {
            Group {
                switch transition {
                case nil:
                    mainView
                case .deliveryAddress:
                    deliveryAddress
                case .paymentMethod:
                    paymentMethod
                }
            }
            .padding(.horizontal)
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
            DSTitledContent("Delivery Address") {
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
            DSTitledContent("Payment Method") {
                Text(viewModel.selectedMethod)
            }
            if let installmentPeriod = viewModel.selectedPeriod {
                DSCaption(title: installmentPeriod)
            }
        }
        .matchedGeometryEffect(id: AnimationID.paymentMethod, in: namespace)
        .onTapGesture {
            withAnimation {
                transition = .paymentMethod
            }
            editedField = .paymentMethod
        }
    }
    
    var deliveryAddress: some View {
        DSCustomSection {
            DeliveryAddressIsland(text: $viewModel.deliveryAddress)
                .focused($editedField, equals: .deliveryAddress)
        }
        .matchedGeometryEffect(id: AnimationID.deliveryAddress, in: namespace)
    }
    
    var paymentMethod: some View {
        VStack {
            Picker("Payment Method", selection: $viewModel.selectedMethod) {
                ForEach(viewModel.paymentMethods, id: \.self) {
                    Text($0).tag($0)
                }
            }
            if viewModel.areInstallmentPeriodsAvailable {
                Picker("Payment Method", selection: $viewModel.selectedPeriod) {
                    ForEach(viewModel.installmentPeriods, id: \.self) {
                        Text($0).tag(Optional($0))
                    }
                }
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .animation(.bouncy, value: viewModel.areInstallmentPeriodsAvailable)
        .pickerStyle(.segmented)
        .matchedGeometryEffect(id: AnimationID.paymentMethod, in: namespace)
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
}

private final class MockViewModel: OrderSummaryViewModel {
    @Published var deliveryAddress = "Zug"

    @Published var areInstallmentPeriodsAvailable: Bool = false
    @Published var selectedPeriod: String? = nil
    var installmentPeriods: [String] = []

    @Published var selectedMethod = "Cash"
    @Published var paymentMethods = ["Cash", "Card", "Installment"]
    
    func completeOrder() {}
}
