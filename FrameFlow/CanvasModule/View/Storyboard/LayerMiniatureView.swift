//
//  LayerMiniatureView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 11/2/24.
//

import SwiftUI

/// A view that renders a scaled-down miniature representation of a layer’s lines for display in layer previews.
struct LayerMiniatureView: View {
    
    // MARK: - Properties
    
    /// The lines to be rendered in the miniature view.
    private let lines: [Line]
    /// The scale factor used to reduce the size of the lines for the miniature display.
    private let scaleFactor: CGFloat

    // MARK: - Initializer
    
    /// Initializes the `LayerMiniatureView` with a set of lines and an optional scale factor.
    /// - Parameters:
    ///   - lines: The lines that make up the layer.
    ///   - scaleFactor: The scale factor for resizing the lines. Defaults to 0.13.
    init(lines: [Line], scaleFactor: CGFloat = 0.13) {
        self.lines = lines
        self.scaleFactor = scaleFactor
    }
    
    // MARK: - Body

    /// The main content of the miniature view, rendering each line as a scaled path.
    internal var body: some View {
        ZStack {
            ForEach(lines) { line in
                Path { path in
                    // Ensure there's at least one point to start the path
                    guard let firstPoint = line.points.first else { return }
                    path.move(to: CGPoint(x: firstPoint.x * scaleFactor, y: firstPoint.y * scaleFactor))
                    
                    // Add each subsequent point to the path, scaled accordingly
                    for point in line.points.dropFirst() {
                        path.addLine(to: CGPoint(x: point.x * scaleFactor, y: point.y * scaleFactor))
                    }
                }
                .stroke(line.color, lineWidth: line.lineWidth * scaleFactor)
            }
        }
        .frame(width: 50, height: 85)
    }
}
