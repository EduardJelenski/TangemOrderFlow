//
//  View+bottomButtonAction.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 26.11.2024.
//

import SwiftUI

extension View {
    
    func bottomButtonAction(_ title: String, action: @escaping () -> ()) -> some View {
        modifier(BottomButtonActionModifier(title: title, action: action))
    }
}

struct BottomButtonActionModifier: ViewModifier {
    
    let title: String
    let action: () -> ()
    
    func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: .bottom) {
                DSBottomButton(title, action: action)
                    .padding()
            }
    }
}
