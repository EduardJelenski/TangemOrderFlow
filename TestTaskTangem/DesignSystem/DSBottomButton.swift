//
//  DSBottomButton.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 26.11.2024.
//

import SwiftUI

struct DSBottomButton: View {
    
    let title: LocalizedStringKey
    let action: () -> ()
    
    init(_ title: LocalizedStringKey, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .dsButton()
        }
    }
}
