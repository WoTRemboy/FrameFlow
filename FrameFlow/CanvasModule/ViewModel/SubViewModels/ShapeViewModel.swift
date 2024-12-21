//
//  ShapeViewModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 11/1/24.
//

import SwiftUI

extension CanvasViewModel {
    
    // MARK: - Shape Picker Management
    
    /// Toggles the shape picker visibility and sets the drawing mode to shape.
    internal func toggleShapePicker() {
        withAnimation(.easeInOut(duration: 0.2)) {
            showShapePicker.toggle()
            showColorPicker = false
            currentMode = .shape
        }
    }
    
    /// Sets the currently selected shape type.
    /// - Parameter shape: The `ShapeMode` to be selected.
    internal func selectShape(_ shape: ShapeMode) {
        currentShape = shape
    }
    
    // MARK: - Shape Interaction
    
    /// Updates the preview of the shape as the user drags.
    /// - Parameter currentPoint: The current touch location during the drag.
    internal func updateShape(to location: CGPoint, in size: CGSize) {
        guard let shape = currentShape else { return }
        
        let deltaX = location.x - tapLocation.x
        let deltaY = location.y - tapLocation.y
        let maxDelta = max(abs(deltaX), abs(deltaY))
        let proportionalSize = CGSize(width: maxDelta * 2, height: maxDelta * 2)
        let angle = atan2(-deltaX, deltaY)
        
        previewShapeLines = createPreviewLinesForShape(
            shape,
            at: tapLocation,
            size: proportionalSize,
            rotation: angle
        )
    }
    
    /// Finalizes the shape drawing by adding it to the current layer.
    internal func finalizeShape() {
        let segmentedLines = previewShapeLines.flatMap { line in
            createSegmentedLine(from: line.points.first!, to: line.points.last!, color: line.color, lineWidth: line.lineWidth)
        }
        
        currentLayer.append(contentsOf: segmentedLines)
        undoStack.append(Action(type: .addShape(segmentedLines, layerIndex: currentLayerIndex)))
        redoStack.removeAll()
        
        previewShapeLines.removeAll()
        currentShape = nil
        currentMode = .shape
    }
    
    // MARK: - Shape Creation
    
    /// Generates lines for different shapes, adjusting properties such as color and line width.
    /// - Parameters:
    ///   - shape: The shape type, represented by `ShapeMode`.
    ///   - point: The center point of the shape.
    ///   - color: The color of the shape lines.
    ///   - lineWidth: The line width for each line segment of the shape.
    ///   - height: The size of the shape.
    /// - Returns: An array of `Line` objects representing the shape.
    private func createPreviewLinesForShape(_ shape: ShapeMode, at center: CGPoint, size: CGSize, rotation: CGFloat) -> [Line] {
        var lines: [Line] = []
        let limitedSize = CGSize(
            width: max(size.width, 30),
            height: max(size.height, 30)
        )
        
        let halfWidth = limitedSize.width / 2
        let halfHeight = limitedSize.height / 2
        
        func rotatePoint(_ point: CGPoint, around center: CGPoint, by angle: CGFloat) -> CGPoint {
            let dx = point.x - center.x
            let dy = point.y - center.y
            
            let rotatedX = center.x + dx * cos(angle) - dy * sin(angle)
            let rotatedY = center.y + dx * sin(angle) + dy * cos(angle)
            
            return CGPoint(x: rotatedX, y: rotatedY)
        }
        
        switch shape {
        case .square:
            let topLeft = CGPoint(x: center.x - halfWidth, y: center.y - halfHeight)
            let topRight = CGPoint(x: center.x + halfWidth, y: center.y - halfHeight)
            let bottomRight = CGPoint(x: center.x + halfWidth, y: center.y + halfHeight)
            let bottomLeft = CGPoint(x: center.x - halfWidth, y: center.y + halfHeight)
            
            let rotatedPoints = [
                rotatePoint(topLeft, around: center, by: rotation),
                rotatePoint(topRight, around: center, by: rotation),
                rotatePoint(bottomRight, around: center, by: rotation),
                rotatePoint(bottomLeft, around: center, by: rotation)
            ]
            
            lines.append(Line(points: [rotatedPoints[0], rotatedPoints[1]], color: selectedColor, lineWidth: lineWidth))
            lines.append(Line(points: [rotatedPoints[1], rotatedPoints[2]], color: selectedColor, lineWidth: lineWidth))
            lines.append(Line(points: [rotatedPoints[2], rotatedPoints[3]], color: selectedColor, lineWidth: lineWidth))
            lines.append(Line(points: [rotatedPoints[3], rotatedPoints[0]], color: selectedColor, lineWidth: lineWidth))
            
        case .circle:
            let radius = max(limitedSize.width / 2, 10)
            let segments = max(Int(radius / 2), 18)
            var circlePoints: [CGPoint] = []
            
            for i in 0...segments {
                let angle = 2 * .pi * CGFloat(i) / CGFloat(segments)
                let x = center.x + radius * cos(angle)
                let y = center.y + radius * sin(angle)
                circlePoints.append(rotatePoint(CGPoint(x: x, y: y), around: center, by: rotation))
            }
            
            for i in 0..<segments {
                lines.append(Line(points: [circlePoints[i], circlePoints[i + 1]], color: selectedColor, lineWidth: lineWidth))
            }
            
        case .triangle:
            let top = CGPoint(x: center.x, y: center.y - halfHeight)
            let bottomLeft = CGPoint(x: center.x - halfWidth, y: center.y + halfHeight)
            let bottomRight = CGPoint(x: center.x + halfWidth, y: center.y + halfHeight)
            
            let rotatedPoints = [
                rotatePoint(top, around: center, by: rotation),
                rotatePoint(bottomLeft, around: center, by: rotation),
                rotatePoint(bottomRight, around: center, by: rotation)
            ]
            
            lines.append(Line(points: [rotatedPoints[0], rotatedPoints[1]], color: selectedColor, lineWidth: lineWidth))
            lines.append(Line(points: [rotatedPoints[1], rotatedPoints[2]], color: selectedColor, lineWidth: lineWidth))
            lines.append(Line(points: [rotatedPoints[2], rotatedPoints[0]], color: selectedColor, lineWidth: lineWidth))
            
        case .arrow:
            let top = CGPoint(x: center.x, y: center.y - halfHeight)
            let bottom = CGPoint(x: center.x, y: center.y + halfHeight)
            let leftWing = CGPoint(x: center.x - halfWidth / 2, y: center.y - halfHeight / 2)
            let rightWing = CGPoint(x: center.x + halfWidth / 2, y: center.y - halfHeight / 2)
            
            let rotatedPoints = [
                rotatePoint(top, around: center, by: rotation),
                rotatePoint(bottom, around: center, by: rotation),
                rotatePoint(leftWing, around: center, by: rotation),
                rotatePoint(rightWing, around: center, by: rotation)
            ]
            
            lines.append(Line(points: [rotatedPoints[0], rotatedPoints[1]], color: selectedColor, lineWidth: lineWidth))
            lines.append(Line(points: [rotatedPoints[2], rotatedPoints[0]], color: selectedColor, lineWidth: lineWidth))
            lines.append(Line(points: [rotatedPoints[3], rotatedPoints[0]], color: selectedColor, lineWidth: lineWidth))
        }
        
        return lines
    }
    
    // MARK: - Segmented Line Creation
    
    /// Creates a segmented line between two points, dividing it into shorter segments.
    /// - Parameters:
    ///   - start: The starting point of the line segment.
    ///   - end: The endpoint of the line segment.
    ///   - color: The color of the line segment.
    ///   - lineWidth: The line width of each segment.
    ///   - segmentLength: The length of each segment in the line.
    ///   - isCircle: A flag indicating if the shape is a circle, which influences how segments connect.
    /// - Returns: An array of `Line` segments.
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
}
