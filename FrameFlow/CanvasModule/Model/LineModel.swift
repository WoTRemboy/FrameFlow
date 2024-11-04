//
//  LineModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/29/24.
//

import SwiftUI

// MARK: - Line

/// Represents a drawable line on the canvas, which consists of multiple points and visual properties.
struct Line: Equatable, Identifiable {
    /// A unique identifier for each line, enabling it to be tracked independently.
    let id = UUID()
    /// An array of points that make up the line, defining its path.
    var points: [CGPoint]
    /// The color of the line.
    var color: Color
    /// The width of the line, controlling its thickness on the canvas.
    var lineWidth: CGFloat
    /// The type of line, determining the drawing style (e.g., pencil, brush).
    var lineType: LineType = .pencil
}

// MARK: - LineType

/// Specifies the different types of lines available, each with unique visual characteristics.
enum LineType {
    /// A precise, thin line for detailed drawing.
    case pencil
    /// A softer line that includes blur.
    case brush
}
