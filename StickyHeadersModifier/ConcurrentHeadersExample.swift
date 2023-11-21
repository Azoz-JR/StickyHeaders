//
//  ConcurrentHeadersExample.swift
//  StickyHeadersModifier
//
//  Created by Azoz Salah on 21/11/2023.
//

import SwiftUI

struct ConcurrentHeadersExample: View {
    @State private var frame: CGRect = .zero
    @State private var frame2: CGRect = .zero
    
    var offset1: CGFloat {
        if frame.minY < 0 {
            return -frame.minY
        } else {
            return 0
        }
    }
    
    var offset2: CGFloat {
        if frame2.minY - 50 < 0 {
            return -frame2.minY + 50
        } else {
            return 0
        }
    }
    
    var body: some View {
        NavigationStack {
        ScrollView {
            VStack {
                // Header 1
                Text("Header 1")
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .sticky(container: "container")
                
                
                // Content 1
                ForEach(0..<20) { num in
                    Text("Content 1")
                        .frame(width: 200, height: 200)
                        .background(.yellow)
                }
                
                // Header 2
                Text("Header 2")
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .sticky(container: "container", offset: 50)
                
                ForEach(0..<20) { num in
                    Text("Content 2")
                        .frame(width: 200, height: 200)
                        .background(.yellow)
                }
                
            }
            .frame(maxWidth: .infinity)
        }
        .coordinateSpace(name: "container")
        .navigationTitle("Sticky")
        .background(.gray)
    }
    }
}

#Preview {
    ConcurrentHeadersExample()
}
