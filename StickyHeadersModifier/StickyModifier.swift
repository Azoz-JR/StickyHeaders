//
//  StickyModifier.swift
//  StickyHeadersModifier
//
//  Created by Azoz Salah on 21/11/2023.
//

import Foundation

import Foundation
import SwiftUI


struct Sticky: ViewModifier {
    // The container view of the sticky header
    var container: String
    
    // The height of the previous header in case of multiple concurrent headers
    var offset: CGFloat
    
    // Array of frames of sticky headers in case of multiple pushing headers
    var stickyRects: [CGRect]
    
    // The frame of the sticky header view
    @State private var frame: CGRect = .zero
    
    init(container: String) {
        self.container = container
        self.offset = 0
        self.stickyRects = []
    }
    
    init(container: String, offset: CGFloat) {
        self.container = container
        self.offset = offset
        self.stickyRects = []
    }
    
    init(container: String, stickyRects: [CGRect]) {
        self.container = container
        self.offset = 0
        self.stickyRects = stickyRects
    }
    
    //Check if the header reaches the top of the screen
    var isSticking: Bool {
        frame.minY < offset
    }
    
    var offsetValue: CGFloat {
        guard isSticking else {
            return 0
        }
        
        // Adding the previous header height to the offset value
        var offsetValue = -frame.minY + offset
        
        // Checking if the next header reaches the top in case of multiple pushing headers
        if let index = stickyRects.firstIndex(where: { headerFrame in
            headerFrame.minY > frame.minY && headerFrame.minY < frame.height
        }) {
            let nextHeader = stickyRects[index]
            offsetValue -= frame.height - nextHeader.minY
        }
        
        return offsetValue
    }
    
    func body(content: Content) -> some View {
        content
            .offset(y: offsetValue)
            .zIndex(.infinity)
            .overlay {
                GeometryReader { proxy in
                    let f = proxy.frame(in: .named(container))
                    Color.clear
                        .onAppear {
                            frame = f
                        }
                        .onChange(of: f) { _, newValue in
                            frame = newValue
                        }
                        .preference(key: FramePreference.self, value: [frame])
                }
            }
    }
}

extension View {
    /// Stick the view to the top of the container
    ///
    func sticky(container: String) -> some View {
        modifier(Sticky(container: container))
    }
    
    /// Stick the view to the top of the container with offset value
    func sticky(container: String, offset: CGFloat) -> some View {
        modifier(Sticky(container: container, offset: offset))
    }
    
    /// Make sticky headers push each other when reach the top of the container
    func sticky(container: String, _ stickyRects: [CGRect]) -> some View {
        modifier(Sticky(container: container, stickyRects: stickyRects))
    }
}
