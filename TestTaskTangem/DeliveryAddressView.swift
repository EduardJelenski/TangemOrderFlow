//
//  DeliveryAddressView.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 23.11.2024.
//

import SwiftUI

protocol DeliveryAddressViewModel: ObservableObject {
    var address: String { get set }
}

final class DeliveryAddressViewModelImpl: DeliveryAddressViewModel {
    @Published var address = ""
}

struct DeliveryAddressView<ViewModel: DeliveryAddressViewModel>: View {
    
    @StateObject var viewModel: ViewModel
    @FocusState var isFocused: Bool
    
    var body: some View {
        ScrollView {
            addressSection
                .padding(.top)
        }
        .onTapGesture {
            isFocused = false
        }
        .background(.lightGray)
        .safeAreaInset(edge: .bottom) {
            bottomButton
        }
        .navigationBarHidden(true)
    }
    
    private var bottomButton: some View {
        NavigationLink {
            PaymentOptionView(viewModel: PaymentOptionViewModelImpl())
        } label: {
            Text("Continue")
                .dsButton()
                .padding(.horizontal)
        }
    }
    
    private var addressSection: some View {
        CustomSection {
            TitledContent("Delivery address") {
                TextField(
                    "Delivery Address",
                    text: $viewModel.address,
                    prompt: Text("Switzerland, Zug, 12 Bitcoin St., Tangem LLC.")
                )
                .focused($isFocused)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack {
        DeliveryAddressView(viewModel: DeliveryAddressViewModelImpl())
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

struct TitledContent<Content: View>: View {
    
    let title: String
    let content: Content
    
    init(_ title: String, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.title = title
    }
    
    var body: some View {
        Text(title)
            .bold()
        
        content
    }
}
