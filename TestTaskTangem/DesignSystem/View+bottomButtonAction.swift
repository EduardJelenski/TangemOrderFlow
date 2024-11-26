//
//  View+bottomButtonAction.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 26.11.2024.
//

import SwiftUI

extension View {
    
    func bottomButtonAction(_ title: LocalizedStringKey, action: @escaping () -> ()) -> some View {
        modifier(BottomButtonActionModifier(title: title, action: action))
    }
}

private struct BottomButtonActionModifier: ViewModifier {
    
    let title: LocalizedStringKey
    let action: () -> ()
    
    func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: .bottom) {
                DSBottomButton(title, action: action)
                    .padding()
            }
    }
}
