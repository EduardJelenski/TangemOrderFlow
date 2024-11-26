//
//  DSCaption.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 27.11.2024.
//

import SwiftUI

struct DSCaption: View {
    
    let title: LocalizedStringKey
    
    var body: some View {
        Text(title)
            .font(.caption)
    }
}
