//
//  CanvasView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/29/24.
//

import SwiftUI

/// A view that represents the drawing canvas, displaying lines, shapes, and previous layers with customizable drawing and erasing tools.
struct CanvasView: View {
    
    // MARK: - Properties
    
    /// The shared view model that manages the canvas state, layers, and actions.
    @EnvironmentObject var viewModel: CanvasViewModel
    
    /// A binding to the lines in the current layer.
    @Binding internal var lines: [Line]
    /// A binding to the line currently being drawn.
    @Binding internal var currentLine: Line
    /// A binding to the eraser line, active when erasing.
    @Binding internal var currentEraserLine: Line
    /// The size of the canvas area.
    internal var canvasSize: CGSize
    
    // MARK: - Body
    
    /// The main body of the canvas, displaying active lines and a preview of the previous layer if available.
    internal var body: some View {
        ZStack {
            // Display the previous layer faintly in the background if applicable
            if viewModel.currentLayerIndex > 0, !viewModel.isAnimating {
                let previousLayerIndex = viewModel.currentLayerIndex - 1
                ForEach(viewModel.layers[previousLayerIndex]) { line in
                    if line.lineType == .brush {
                        brushPath(for: line)
                    } else {
                        pencilPath(for: line)
                    }
                }
                .opacity(0.3)
            }
            
            // Display lines in the current layer
            ForEach(viewModel.currentLayer) { line in
                if line.lineType == .brush {
                    brushPath(for: line)
                } else {
                    pencilPath(for: line)
                }
            }
            .opacity(1.0)
            
            ForEach(viewModel.previewShapeLines) { line in
                pencilPath(for: line)
            }
            .opacity(1.0)
            
            // Display either the current drawing line or the eraser path, based on the active tool
            if currentEraserLine.points.isEmpty {
                if currentLine.lineType == .brush {
                    brushPath(for: currentLine)
                } else {
                    pencilPath(for: currentLine)
                }
            } else {
                eraserPath(for: currentEraserLine)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .onAppear {
            viewModel.canvasSize = canvasSize
        }
    }
    
    // MARK: - Path Rendering
    
    /// Draws the path for a pencil line, with a standard stroke style.
    private func pencilPath(for line: Line) -> some View {
        Path { path in
            guard let firstPoint = line.points.first else { return }
            path.move(to: firstPoint)
            for point in line.points.dropFirst() {
                path.addLine(to: point)
            }
        }
        .stroke(line.color, style: StrokeStyle(lineWidth: line.lineWidth, lineCap: .round, lineJoin: .round))
    }
    
    /// Draws the path for a brush line, applying a blur effect to give a softer look.
    private func brushPath(for line: Line) -> some View {
        Path { path in
            guard let firstPoint = line.points.first else { return }
            path.move(to: firstPoint)
            for point in line.points.dropFirst() {
                path.addLine(to: point)
            }
        }
        .stroke(line.color, style: StrokeStyle(lineWidth: line.lineWidth, lineCap: .round, lineJoin: .round))
        .blur(radius: line.lineWidth / 2)
    }
    
    /// Draws the path for the eraser, applying a semi-transparent gray stroke.
    private func eraserPath(for line: Line) -> some View {
        Path { path in
            guard let firstPoint = line.points.first else { return }
            path.move(to: firstPoint)
            for point in line.points.dropFirst() {
                path.addLine(to: point)
            }
        }
        .stroke(Color.gray.opacity(0.5), style: StrokeStyle(lineWidth: line.lineWidth, lineCap: .round, lineJoin: .round))
    }
}
