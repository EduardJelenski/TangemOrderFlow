//
//  AnimatedExampleView.swift
//  TestTaskTangem
//
//  Created by eelenskiy on 24.11.2024.
//

import SwiftUI

struct NoOpTransition: Animatable, ViewModifier {
    
    var animatableData: CGFloat = 0
    
    init(_ x: CGFloat) {
        animatableData = x
    }
    
    func body(content: Content) -> some View {
        return content
    }
}
extension AnyTransition {
    static let noOp: AnyTransition = .modifier(active: NoOpTransition(1), identity: NoOpTransition(0))
    
    static let no: AnyTransition = .modifier(active: NoOpTransition(1), identity: NoOpTransition(0))
}

struct AnimatedExampleView: View {
    @State var isExpanded: Bool = true
    
    // Identifier for the rectangle view
    private var rectangleId = "Rectangle"
    
    // Namespace for the expansion effect
    @Namespace var expansionAnimation
    
    var body: some View {
        VStack {
            if isExpanded {
                smallSizeView()
            } else {
                largeSizeView()
            }
        }
        .padding()
        .onTapGesture {
            withAnimation {
                isExpanded.toggle()
            }
        }
    }
    
    @ViewBuilder
    func smallSizeView() -> some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(.black)
            .frame(width: 300,height: 300)
            // Added the matched geometry modifier to the view
            .matchedGeometryEffect(id: rectangleId, in: expansionAnimation)
            .transition(.noOp)
            .overlay {
                Text("Hello Developer")
                    .font(.headline)
                    .foregroundStyle(.white)
            }
    }
    
    @ViewBuilder
    func largeSizeView() -> some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(.black)
            // Added the matched geometry modifier to the view
            .matchedGeometryEffect(id: rectangleId, in: expansionAnimation)
            .transition(.no)
            .overlay {
                Text("Hello Developer")
                    .font(.headline)
                    .foregroundStyle(.white)
            }
    }
    
}

#Preview {
    AnimatedExampleView()
}
