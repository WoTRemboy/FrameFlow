//
//  GIFShareView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 11/4/24.
//

import SwiftUI

struct GIFShareView: View {
    private let lines: [Line]
    private let width: CGFloat
    private let height: CGFloat
    
    init(lines: [Line], width: CGFloat, height: CGFloat) {
        self.lines = lines
        self.width = width
        self.height = height
    }
    
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
