//
//  LineModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/29/24.
//

import SwiftUI

struct Line: Equatable, Identifiable {
    let id = UUID()
    var points: [CGPoint]
    var color: Color
    var lineWidth: CGFloat
    var lineType: LineType = .pencil
}

enum LineType {
    case pencil
    case brush
}
