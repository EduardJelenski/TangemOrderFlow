//
//  DSTitledTextField.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 26.11.2024.
//

import SwiftUI

struct DSTitledTextField: View {
    
    @Binding private var text: String
    
    private let title: LocalizedStringKey
    private let prompt: LocalizedStringKey
    
    init(_ title: LocalizedStringKey, text: Binding<String>, prompt: LocalizedStringKey) {
        self.title = title
        _text = text
        self.prompt = prompt
    }
    
    var body: some View {
        DSTitledContent(title) {
            TextField(
                title,
                text: $text,
                prompt: Text(prompt)
            )
        }
    }
}
