//
//  DSTitledContent.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 26.11.2024.
//

import SwiftUI

struct DSTitledContent<Content: View>: View {
    
    let title: LocalizedStringKey
    let content: Content
    
    init(_ title: LocalizedStringKey, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.title = title
    }
    
    var body: some View {
        DSTitle(title)
        content
    }
}
