//
//  CanvasModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/29/24.
//

// MARK: - CanvasMode

/// Represents the various drawing modes available on the canvas.
enum CanvasMode {
    /// The pencil mode allows users to draw precise lines.
    case pencil
    /// The brush mode provides a broader stroke for drawing with a blurred effect.
    case brush
    /// The eraser mode enables users to remove parts of their drawings from the canvas.
    case eraser
    /// The shape mode allows users to add predefined shapes (e.g., circles, squares) to the canvas.
    case shape
    /// The palette mode enables users to select and apply different colors to the drawing tools or shapes.
    case palette
}
