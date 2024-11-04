//
//  GIFShareView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 11/4/24.
//

import SwiftUI

/// A view used to render lines as part of a GIF creation process.
struct GIFShareView: View {
    
    // MARK: - Properties
    
    /// The lines to be rendered on the canvas.
    private let lines: [Line]
    /// The width of the view.
    private let width: CGFloat
    /// The height of the view.
    private let height: CGFloat
    
    // MARK: - Initializer
    
    /// Initializes the GIFShareView with the specified lines and canvas size.
    /// - Parameters:
    ///   - lines: The lines to be drawn in the GIF frame.
    ///   - width: The width of the canvas.
    ///   - height: The height of the canvas.
    init(lines: [Line], width: CGFloat, height: CGFloat) {
        self.lines = lines
        self.width = width
        self.height = height
    }
    
    // MARK: - Body
    
    /// The main content of the view, which consists of the lines rendered over a white background.
    internal var body: some View {
        ZStack {
            Color.white
            ForEach(lines) { line in
                Path { path in
                    guard let firstPoint = line.points.first else { return }
                    path.move(to: firstPoint)
                    for point in line.points.dropFirst() {
                        path.addLine(to: point)
                    }
                }
                .stroke(line.color, style: StrokeStyle(lineWidth: line.lineWidth, lineCap: .round, lineJoin: .round))
            }
        }
        .frame(width: width, height: height)
    }
}
