//
//  CanvasView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/29/24.
//

// CanvasView.swift

import SwiftUI

struct CanvasView: View {
    @Binding internal var lines: [Line]
    @Binding internal var currentLine: Line
    @Binding internal var currentEraserLine: Line
    internal var canvasSize: CGSize
    
    internal var body: some View {
        ZStack {
            ForEach(lines.indices, id: \.self) { index in
                let line = lines[index]
                if line.lineType == .brush {
                    brushPath(for: line)
                } else {
                    pencilPath(for: line)
                }
            }
            
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
    }
        
    private func pencilPath(for line: Line) -> some View {
        Path { path in
            guard let firstPoint = line.points.first else { return }
            path.move(to: firstPoint)
            for point in line.points.dropFirst() {
                path.addLine(to: point)
            }
        }
        .stroke(line.color, lineWidth: line.lineWidth)
    }
    
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
    
    private func eraserPath(for line: Line) -> some View {
        Path { path in
            guard let firstPoint = line.points.first else { return }
            path.move(to: firstPoint)
            for point in line.points.dropFirst() {
                path.addLine(to: point)
            }
        }
        .stroke(Color.gray.opacity(0.5), lineWidth: line.lineWidth)
    }
}
