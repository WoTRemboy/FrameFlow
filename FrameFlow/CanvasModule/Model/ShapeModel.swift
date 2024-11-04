//
//  ShapeModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/31/24.
//

import SwiftUI

// MARK: - ShapeMode

/// Represents the various shape types that can be drawn on the canvas.
enum ShapeMode {
    /// A square shape with four equal sides.
    case square
    /// A circular shape with equal radius in all directions from its center.
    case circle
    /// A triangular shape with three sides.
    case triangle
    /// An arrow shape.
    case arrow
}

// MARK: - ShapeItem

/// Represents a drawable shape on the canvas, storing its properties such as type, position, color, and dimensions.
struct ShapeItem {
    /// The type of shape (e.g., square, circle).
    var shape: ShapeMode
    /// The position of the shape’s center on the canvas.
    var position: CGPoint
    /// The color of the shape’s outline.
    var color: Color
    /// The width of the shape's outline.
    var lineWidth: CGFloat
    /// The height or diameter of the shape.
    var height: CGFloat
}
