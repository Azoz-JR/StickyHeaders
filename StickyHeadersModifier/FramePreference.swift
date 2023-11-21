//
//  FramePreference.swift
//  StickyHeadersForScrollViews
//
//  Created by Azoz Salah on 17/11/2023.
//

import Foundation
import SwiftUI


struct FramePreference: PreferenceKey {
    static var defaultValue: [CGRect] = []
    
    static func reduce(value: inout [CGRect], nextValue: () -> [CGRect]) {
        value.append(contentsOf: nextValue())
    }
}
