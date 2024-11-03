//
//  LayerMiniatureView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 11/2/24.
//

import SwiftUI

struct LayerMiniatureView: View {
    let lines: [Line]
    let scaleFactor: CGFloat

    init(lines: [Line], scaleFactor: CGFloat = 0.13) {
        self.lines = lines
        self.scaleFactor = scaleFactor
    }

    var body: some View {
        ZStack {
            ForEach(lines) { line in
                Path { path in
                    guard let firstPoint = line.points.first else { return }
                    path.move(to: CGPoint(x: firstPoint.x * scaleFactor, y: firstPoint.y * scaleFactor))
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
