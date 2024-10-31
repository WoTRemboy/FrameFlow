//
//  ShapeModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/31/24.
//

import SwiftUI

enum ShapeMode {
    case square
    case circle
    case triangle
    case arrow
}

struct ShapeItem {
    var shape: ShapeMode
    var position: CGPoint
    var color: Color
    var lineWidth: CGFloat
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX - rect.width * 0.1, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX - rect.width * 0.1, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX + rect.width * 0.1, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX + rect.width * 0.1, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.closeSubpath()
        return path
    }
}
