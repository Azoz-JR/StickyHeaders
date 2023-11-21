//
//  PushingHeadersExample.swift
//  StickyHeadersModifier
//
//  Created by Azoz Salah on 21/11/2023.
//

import SwiftUI

struct PushingHeadersExample: View {
    @State private var frames: [CGRect] = []
    
    let text = """
    PUSHING HEADER IS COMING
    PUSHING HEADER IS COMING
    PUSHING HEADER IS COMING
    PUSHING HEADER IS COMING
    PUSHING HEADER IS COMING
    PUSHING HEADER IS COMING
"""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(0..<50) { ix in
                    Text("Heading \(ix)")
                        .font(.title)
                        .frame(maxWidth: .infinity)
                        .background(.regularMaterial)
                        .sticky(container: "container", frames)
                    
                    Text(text)
                }
            }
            .coordinateSpace(name: "container")
            .navigationTitle("Pushing Headers")
        }
    }
}

#Preview {
    PushingHeadersExample()
}
