//
//  DSCustomSection.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 25.11.2024.
//

import SwiftUI

struct DSCustomSection<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack {
            content
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(.white)
        .cornerRadius(8)
    }
}
