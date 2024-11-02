//
//  DrawingViewModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 11/1/24.
//

import SwiftUI

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
            currentLayer.append(currentLine)
            undoStack.append(Action(type: .addLine(currentLine, layerIndex: currentLayerIndex)))
            redoStack.removeAll()
            
            currentLine = Line(points: [], color: selectedColor, lineWidth: lineWidth)
            
        case .eraser:
            let originalLines = currentLayer
            eraseLinesIntersectingWithEraser()
            
            if !originalLines.isEmpty {
                undoStack.append(Action(type: .removeLine(originalLines, layerIndex: currentLayerIndex)))
                redoStack.removeAll()
            }
            
            currentEraserLine = Line(points: [], color: .clear, lineWidth: lineWidth)
            
        default:
            break
        }
    }
    
    
    private func eraseLinesIntersectingWithEraser() {
        let eraserRadius = currentEraserLine.lineWidth / 1.5
        var newLines: [Line] = []
        var removedLines: [Line] = []
        
        var eraserSegments: [(CGPoint, CGPoint)] = []
        let eraserPoints = currentEraserLine.points
        for i in 0..<eraserPoints.count - 1 {
            let eraserStart = eraserPoints[i]
            let eraserEnd = eraserPoints[i + 1]
            eraserSegments.append((eraserStart, eraserEnd))
        }
        
        for line in currentLayer {
            var currentSegmentPoints: [CGPoint] = []
            var newLineSegments: [[CGPoint]] = []
            
            let linePoints = line.points
            var isLineRemoved = false
            
            for i in 0..<linePoints.count - 1 {
                let lineStart = linePoints[i]
                let lineEnd = linePoints[i + 1]
                var shouldEraseSegment = false
                
                for (eraserStart, eraserEnd) in eraserSegments {
                    if segmentsIntersect(lineStart, lineEnd, eraserStart, eraserEnd, eraserRadius: eraserRadius) {
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
                    isLineRemoved = true
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
            
            if isLineRemoved {
                removedLines.append(line)
            }
            
            for segmentPoints in newLineSegments {
                if segmentPoints.count > 1 {
                    newLines.append(Line(points: segmentPoints, color: line.color, lineWidth: line.lineWidth, lineType: line.lineType))
                }
            }
        }
        
        currentLayer = newLines
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
