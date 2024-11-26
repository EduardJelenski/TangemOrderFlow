//
//  DSTitle.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 26.11.2024.
//

import SwiftUI

struct DSTitle: View {
    let title: LocalizedStringKey
    
    init(_ title: LocalizedStringKey) {
        self.title = title
    }
    
    var body: some View {
        Text(title)
            .bold()
    }
}
