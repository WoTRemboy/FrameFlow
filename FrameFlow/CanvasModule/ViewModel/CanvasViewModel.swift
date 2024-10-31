//
//  CanvasViewModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/30/24.
//

import SwiftUI

final class CanvasViewModel: ObservableObject {
    @Published internal var lines: [Line] = []
    @Published internal var currentLine: Line = Line(points: [], color: .black, lineWidth: 5)
    @Published internal var currentEraserLine: Line = Line(points: [], color: .clear, lineWidth: 5)
    
    @Published internal var lineWidth: CGFloat = 5.0
    @Published internal var shapeHeight: CGFloat = 100.0
    
    @Published internal var currentMode: CanvasMode = .pencil
    @Published internal var selectedColor: Color = .black
    
    @Published internal var shapes: [ShapeItem] = []
    @Published internal var currentShape: ShapeMode? = nil
    @Published internal var tapLocation: CGPoint = .zero
    
    @Published internal var showColorPicker: Bool = false
    @Published internal var showColorPalette: Bool = false
    @Published internal var showShapePicker: Bool = false
    
    @Published internal var undoStack: [Action] = []
    @Published internal var redoStack: [Action] = []
    
    internal func selectMode(_ mode: CanvasMode) {
        withAnimation(.easeInOut(duration: 0.2)) {
            showColorPicker = false
            showShapePicker = false
            currentMode = mode
        }
    }
    
    internal func toggleColorPicker() {
        withAnimation(.easeInOut(duration: 0.2)) {
            showColorPicker.toggle()
            showShapePicker = false
            currentMode = .palette
        }
    }
    
    internal func toggleColorPalette() {
        withAnimation(.easeInOut(duration: 0.2)) {
            showColorPalette.toggle()
        }
    }
    
    internal func toggleShapePicker() {
        withAnimation(.easeInOut(duration: 0.2)) {
            showShapePicker.toggle()
            showColorPicker = false
            currentMode = .shape
        }
    }
    
    internal func selectColor(_ color: Color) {
        selectedColor = color
    }
    
    internal func selectShape(_ shape: ShapeMode) {
        currentShape = shape
    }
    
    internal func addShape(at point: CGPoint) {
        guard let shape = currentShape else { return }
        
        let shapeLines = createLinesForShape(shape, at: point, color: selectedColor, lineWidth: lineWidth, height: shapeHeight)
        lines.append(contentsOf: shapeLines)
        
        undoStack.append(Action(type: .addShape(shapeLines)))
        redoStack.removeAll()
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
                lines += createSegmentedLine(from: circlePoints[i], to: circlePoints[i + 1], color: color, lineWidth: lineWidth)
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
    
    private func createSegmentedLine(from start: CGPoint, to end: CGPoint, color: Color, lineWidth: CGFloat, segmentLength: CGFloat = 5.0) -> [Line] {
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
    
    internal func selectTabbarImage(targetMode: CanvasMode, currentMode: CanvasMode,
                                    active: Image, inactive: Image) -> Image {
        if targetMode == currentMode {
            return active
        } else {
            return inactive
        }
    }
    
    internal func selectTrueImage(isActive: Bool, active: Image, inactive: Image) -> Image {
        if isActive {
            return active
        } else {
            return inactive
        }
    }
    
    internal func undo() {
        guard let lastAction = undoStack.popLast() else { return }
        
        switch lastAction.type {
        case .addLine(let line):
            lines.removeAll { $0 == line }
            redoStack.append(lastAction)
            
        case .addShape(let shapeLines):
            lines.removeAll { shapeLines.contains($0) }
            redoStack.append(lastAction)
        }
    }
    
    internal func undoAvailable() -> Bool {
        !undoStack.isEmpty
    }
    
    internal func undoAvailableImage() -> Image {
        if undoStack.isEmpty {
            Image.Header.Arrows.rightInactive
        } else {
            Image.Header.Arrows.rightActive
        }
    }
    
    internal func redo() {
        guard let lastUndoneAction = redoStack.popLast() else { return }
        
        switch lastUndoneAction.type {
        case .addLine(let line):
            lines.append(line)
            undoStack.append(lastUndoneAction)
            
        case .addShape(let shapeLines):
            lines.append(contentsOf: shapeLines)
            undoStack.append(lastUndoneAction)
        }
    }
    
    internal func redoAvailable() -> Bool {
        !redoStack.isEmpty
    }
    
    internal func redoAvailableImage() -> Image {
        if redoStack.isEmpty {
            Image.Header.Arrows.leftInactive
        } else {
            Image.Header.Arrows.leftActive
        }
    }
}


// MARK: - Drawing logic

extension CanvasViewModel {
    internal func updateCurrentLine(with point: CGPoint, in size: CGSize) {
        if point.x >= lineWidth / 2, point.x <= size.width - lineWidth / 2,
           point.y >= lineWidth / 2, point.y <= size.height - lineWidth / 2 {
            switch currentMode {
            case .pencil:
                currentLine.points.append(point)
                currentLine.color = selectedColor
                currentLine.lineWidth = lineWidth
                currentLine.lineType = .pencil
            case .brush:
                currentLine.points.append(point)
                currentLine.color = selectedColor
                currentLine.lineWidth = lineWidth
                currentLine.lineType = .brush
            case .eraser:
                currentEraserLine.points.append(point)
                currentEraserLine.lineWidth = lineWidth
            default:
                break
            }
        }
    }
    
    internal func finalizeCurrentLine() {
        switch currentMode {
        case .pencil, .brush:
            lines.append(currentLine)
            undoStack.append(Action(type: .addLine(currentLine)))
            redoStack.removeAll()
            
            currentLine = Line(
                points: [],
                color: selectedColor,
                lineWidth: lineWidth,
                lineType: currentMode == .pencil ? .pencil : .brush
            )
        case .eraser:
            eraseLinesIntersectingWithEraser()
            currentEraserLine = Line(points: [], color: .clear, lineWidth: lineWidth)
        default:
            break
        }
    }
    
    private func eraseLinesIntersectingWithEraser() {
        let eraserRadius = currentEraserLine.lineWidth / 2
        var newLines: [Line] = []
        
        var eraserSegments: [(CGPoint, CGPoint)] = []
        let eraserPoints = currentEraserLine.points
        for i in 0..<eraserPoints.count - 1 {
            let eraserStart = eraserPoints[i]
            let eraserEnd = eraserPoints[i + 1]
            eraserSegments.append((eraserStart, eraserEnd))
        }
        
        for line in lines {
            var currentSegmentPoints: [CGPoint] = []
            var newLineSegments: [[CGPoint]] = []
            
            let linePoints = line.points
            for i in 0..<linePoints.count - 1 {
                let lineStart = linePoints[i]
                let lineEnd = linePoints[i + 1]
                var shouldEraseSegment = false
                
                let blurRadius: CGFloat = line.lineType == .brush ? (line.lineWidth / 2) : 0
                let combinedRadius = eraserRadius + (line.lineWidth / 2) + blurRadius
                
                for (eraserStart, eraserEnd) in eraserSegments {
                    if segmentsIntersect(
                        lineStart, lineEnd,
                        eraserStart, eraserEnd,
                        eraserRadius: combinedRadius
                    ) {
                        shouldEraseSegment = true
                        break
                    }
                }
                
                if shouldEraseSegment {
                    if !currentSegmentPoints.isEmpty {
                        currentSegmentPoints.append(lineStart)
                        newLineSegments.append(currentSegmentPoints)
                        currentSegmentPoints = []
                    }
                } else {
                    if currentSegmentPoints.isEmpty {
                        currentSegmentPoints.append(lineStart)
                    }
                    currentSegmentPoints.append(lineEnd)
                }
            }
            
            if !currentSegmentPoints.isEmpty {
                newLineSegments.append(currentSegmentPoints)
            }
            
            for segmentPoints in newLineSegments {
                if segmentPoints.count > 1 {
                    newLines.append(
                        Line(
                            points: segmentPoints,
                            color: line.color,
                            lineWidth: line.lineWidth,
                            lineType: line.lineType
                        )
                    )
                }
            }
        }
        
        lines = newLines
    }
    
    private func segmentsIntersect(
        _ p1: CGPoint, _ p2: CGPoint,
        _ q1: CGPoint, _ q2: CGPoint,
        eraserRadius: CGFloat
    ) -> Bool {
        let distance = minDistanceBetweenLineSegments(p1, p2, q1, q2)
        return distance <= eraserRadius
    }
    
    private func minDistanceBetweenLineSegments(
        _ p1: CGPoint, _ p2: CGPoint,
        _ q1: CGPoint, _ q2: CGPoint
    ) -> CGFloat {
        if linesIntersect(p1, p2, q1, q2) {
            return 0.0
        } else {
            return min(
                distancePointToSegment(p1, q1, q2),
                distancePointToSegment(p2, q1, q2),
                distancePointToSegment(q1, p1, p2),
                distancePointToSegment(q2, p1, p2)
            )
        }
    }
    
    private func linesIntersect(_ p1: CGPoint, _ p2: CGPoint, _ q1: CGPoint, _ q2: CGPoint) -> Bool {
        func ccw(_ a: CGPoint, _ b: CGPoint, _ c: CGPoint) -> Bool {
            return (c.y - a.y)*(b.x - a.x) > (b.y - a.y)*(c.x - a.x)
        }
        
        return (ccw(p1, q1, q2) != ccw(p2, q1, q2)) && (ccw(p1, p2, q1) != ccw(p1, p2, q2))
    }
    
    private func distancePointToSegment(_ point: CGPoint, _ segmentStart: CGPoint, _ segmentEnd: CGPoint) -> CGFloat {
        let dx = segmentEnd.x - segmentStart.x
        let dy = segmentEnd.y - segmentStart.y
        if dx == 0 && dy == 0 {
            return hypot(point.x - segmentStart.x, point.y - segmentStart.y)
        }
        
        let t = ((point.x - segmentStart.x) * dx + (point.y - segmentStart.y) * dy) / (dx*dx + dy*dy)
        
        let closestPoint: CGPoint
        if t < 0 {
            closestPoint = segmentStart
        } else if t > 1 {
            closestPoint = segmentEnd
        } else {
            closestPoint = CGPoint(x: segmentStart.x + t * dx, y: segmentStart.y + t * dy)
        }
        
        return hypot(point.x - closestPoint.x, point.y - closestPoint.y)
    }
}
