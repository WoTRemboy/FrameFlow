//
//  CanvasView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/29/24.
//

import SwiftUI

struct CanvasView: View {
    @Binding internal var lines: [Line]
    @Binding internal var currentLine: Line
    internal var canvasSize: CGSize
    
    internal var body: some View {
        ZStack {
            ForEach(lines.indices, id: \.self) { index in
                Path { path in
                    let line = lines[index]
                    guard let firstPoint = line.points.first else { return }
                    path.move(to: firstPoint)
                    for point in line.points.dropFirst() {
                        path.addLine(to: point)
                    }
                }
                .stroke(lines[index].color, lineWidth: lines[index].lineWidth)
            }
            
            Path { path in
                guard let firstPoint = currentLine.points.first else { return }
                path.move(to: firstPoint)
                for point in currentLine.points.dropFirst() {
                    path.addLine(to: point)
                }
            }
            .stroke(currentLine.color, lineWidth: currentLine.lineWidth)
        }
        .clipShape(.rect(cornerRadius: 20))
    }
}
