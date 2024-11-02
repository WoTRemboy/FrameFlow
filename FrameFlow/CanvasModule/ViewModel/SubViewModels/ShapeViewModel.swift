//
//  ShapeViewModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 11/1/24.
//

import SwiftUI

extension CanvasViewModel {
    internal func toggleShapePicker() {
        withAnimation(.easeInOut(duration: 0.2)) {
            showShapePicker.toggle()
            showColorPicker = false
            currentMode = .shape
        }
    }
    
    internal func selectShape(_ shape: ShapeMode) {
        currentShape = shape
    }
    
    internal func addShape(at point: CGPoint) {
        guard let shape = currentShape else { return }
        
        let shapeLines = createLinesForShape(shape, at: point, color: selectedColor, lineWidth: lineWidth, height: shapeHeight)
        currentLayer.append(contentsOf: shapeLines)
        
        withAnimation(.easeInOut(duration: 0.2)) {
            undoStack.append(Action(type: .addShape(shapeLines, layerIndex: currentLayerIndex)))
            redoStack.removeAll()
        }
    }
    
    private func createLinesForShape(_ shape: ShapeMode, at point: CGPoint, color: Color, lineWidth: CGFloat, height: CGFloat) -> [Line] {
        var lines: [Line] = []
        let size: CGFloat = height
        
        switch shape {
        case .square:
            let topLeft = CGPoint(x: point.x - size / 2, y: point.y - size / 2)
            let topRight = CGPoint(x: point.x + size / 2, y: point.y - size / 2)
            let bottomRight = CGPoint(x: point.x + size / 2, y: point.y + size / 2)
            let bottomLeft = CGPoint(x: point.x - size / 2, y: point.y + size / 2)
            
            lines += createSegmentedLine(from: topLeft, to: topRight, color: color, lineWidth: lineWidth)
            lines += createSegmentedLine(from: topRight, to: bottomRight, color: color, lineWidth: lineWidth)
            lines += createSegmentedLine(from: bottomRight, to: bottomLeft, color: color, lineWidth: lineWidth)
            lines += createSegmentedLine(from: bottomLeft, to: topLeft, color: color, lineWidth: lineWidth)
            
        case .circle:
            let segments = Int(height / 2)
            let radius = size / 2
            var circlePoints: [CGPoint] = []
            
            for i in 0...segments {
                let angle = 2 * .pi * CGFloat(i) / CGFloat(segments)
                let x = point.x + radius * cos(angle)
                let y = point.y + radius * sin(angle)
                circlePoints.append(CGPoint(x: x, y: y))
            }
            
            for i in 0..<segments {
                lines += createSegmentedLine(from: circlePoints[i], to: circlePoints[i + 1], color: color, lineWidth: lineWidth, isCircle: true)
            }
            
        case .triangle:
            let top = CGPoint(x: point.x, y: point.y - size / 2)
            let bottomLeft = CGPoint(x: point.x - size / 2, y: point.y + size / 2)
            let bottomRight = CGPoint(x: point.x + size / 2, y: point.y + size / 2)
            
            lines += createSegmentedLine(from: top, to: bottomLeft, color: color, lineWidth: lineWidth)
            lines += createSegmentedLine(from: bottomLeft, to: bottomRight, color: color, lineWidth: lineWidth)
            lines += createSegmentedLine(from: bottomRight, to: top, color: color, lineWidth: lineWidth)
            
        case .arrow:
            let top = CGPoint(x: point.x, y: point.y - size / 2)
            let bottom = CGPoint(x: point.x, y: point.y + size / 2)
            let leftWing = CGPoint(x: point.x - size / 4, y: point.y - size / 4)
            let rightWing = CGPoint(x: point.x + size / 4, y: point.y - size / 4)
            
            lines += createSegmentedLine(from: top, to: bottom, color: color, lineWidth: lineWidth)
            lines += createSegmentedLine(from: leftWing, to: top, color: color, lineWidth: lineWidth)
            lines += createSegmentedLine(from: rightWing, to: top, color: color, lineWidth: lineWidth)
        }
        
        return lines
    }
    
    private func createSegmentedLine(from start: CGPoint, to end: CGPoint, color: Color, lineWidth: CGFloat, segmentLength: CGFloat = 5.0, isCircle: Bool = false) -> [Line] {
        var segments: [Line] = []
        
        let dx = end.x - start.x
        let dy = end.y - start.y
        let distance = hypot(dx, dy)
        let segmentCount = Int(distance / segmentLength)
        
        for i in 0..<segmentCount {
            let t1 = CGFloat(i) / CGFloat(segmentCount)
            let t2 = CGFloat(i + 1) / CGFloat(segmentCount)
            
            let x1 = start.x + t1 * dx
            let y1 = start.y + t1 * dy
            let x2 = start.x + t2 * dx
            let y2 = start.y + t2 * dy
            
            segments.append(Line(points: [CGPoint(x: x1, y: y1), CGPoint(x: x2, y: y2)], color: color, lineWidth: lineWidth))
        }
        
        return segments
    }
    
    internal func finalizeShape() {
        currentShape = nil
        currentMode = .shape
    }
}
