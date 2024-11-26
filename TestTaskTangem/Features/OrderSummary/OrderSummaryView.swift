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
            DSTitledContent("Payment Way") {
                Text(viewModel.paymentWay)
            }
            if let installmentPeriod = viewModel.installmentPeriod {
                DSCaption(title: .init(installmentPeriod))
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
                ForEach(viewModel.paymentMethods, id: \.self) {
                    Text($0).tag($0)
                }
            } label: {
                DSTitle("Payment Way")
            }
            if viewModel.areInstallmentPeriodsAvailable {
                Picker(selection: $viewModel.installmentPeriod) {
                    ForEach(viewModel.installmentPeriods, id: \.self) {
                        Text($0).tag(Optional($0))
                    }
                } label: {
                    DSTitle("Payment Way")
                }
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .animation(.bouncy, value: viewModel.areInstallmentPeriodsAvailable)
        .pickerStyle(.segmented)
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
    var areInstallmentPeriodsAvailable: Bool = false

    var installmentPeriods: [String] = []

    @Published var installmentPeriod: String? = ""

    @Published var deliveryAddress = ""
    
    @Published var paymentWay = ""
    
    @Published var paymentMethods = ["Cash", "Card", "Installment"]
    
    func completeOrder() {
        
    }
}
