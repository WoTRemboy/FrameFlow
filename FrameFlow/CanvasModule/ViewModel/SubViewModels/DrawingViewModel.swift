//
//  DrawingViewModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 11/1/24.
//

import SwiftUI

extension CanvasViewModel {
    
    // MARK: - Update Current Line
    
    /// Updates the `currentLine` with a new point while ensuring the canvas is not in animation mode.
    /// - Parameters:
    ///   - point: The new point to add.
    ///   - size: The size of the canvas, used to ensure points remain within the drawable area.
    internal func updateCurrentLine(with point: CGPoint, in size: CGSize) {
        guard !isAnimating else { return }
        
        // Check if the point is within the canvas bounds before adding it
        if point.x >= lineWidth / 2, point.x <= size.width - lineWidth / 2,
           point.y >= lineWidth / 2, point.y <= size.height - lineWidth / 2 {
            
            // Depending on the current mode, update the line with the new point
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
    
    // MARK: - Finalize Current Line
    
    /// Finalizes the `currentLine` by adding it to the active layer.
    ///
    /// Also manages undo/redo stacks, stores actions, and resets line data based on the current mode.
    internal func finalizeCurrentLine() {
        guard !isAnimating else { return }
        
        switch currentMode {
        case .pencil, .brush:
            // Append the current line to the active layer
            currentLayer.append(currentLine)
            undoStack.append(Action(type: .addLine(currentLine, layerIndex: currentLayerIndex)))
            redoStack.removeAll()
            
            currentLine = Line(points: [], color: selectedColor, lineWidth: lineWidth)
            
        case .eraser:
            // Save the original lines before erasing for undo/redo functionality
            let originalLines = currentLayer
            eraseLinesIntersectingWithEraser()
            
            // Record the erasing action if any lines were removed
            if !originalLines.isEmpty {
                undoStack.append(Action(type: .removeLine(originalLines, layerIndex: currentLayerIndex)))
                redoStack.removeAll()
            }
            
            currentEraserLine = Line(points: [], color: .clear, lineWidth: lineWidth)
            
        default:
            break
        }
    }
    
    // MARK: - Erase Lines Intersecting with Eraser
    
    /// Removes or segments lines that intersect with the `currentEraserLine`, allowing partial erasing.
    ///
    /// Evaluates each line against the eraser's path and segments lines when intersections occur.
    private func eraseLinesIntersectingWithEraser() {
        guard !isAnimating else { return }
        
        let eraserRadius = currentEraserLine.lineWidth / 1.5
        var newLines: [Line] = []
        var removedLines: [Line] = []
        
        // Break eraser path into segments for intersection checks
        var eraserSegments: [(CGPoint, CGPoint)] = []
        let eraserPoints = currentEraserLine.points
        for i in 0..<eraserPoints.count - 1 {
            let eraserStart = eraserPoints[i]
            let eraserEnd = eraserPoints[i + 1]
            eraserSegments.append((eraserStart, eraserEnd))
        }
        
        // Process each line in the current layer
        for line in currentLayer {
            var currentSegmentPoints: [CGPoint] = []
            var newLineSegments: [[CGPoint]] = []
            
            let linePoints = line.points
            var isLineRemoved = false
            
            // Check each segment of the line for intersections
            for i in 0..<linePoints.count - 1 {
                let lineStart = linePoints[i]
                let lineEnd = linePoints[i + 1]
                var shouldEraseSegment = false
                
                // Check intersection with each eraser segment
                for (eraserStart, eraserEnd) in eraserSegments {
                    if segmentsIntersect(lineStart, lineEnd, eraserStart, eraserEnd, eraserRadius: eraserRadius) {
                        shouldEraseSegment = true
                        break
                    }
                }
                
                if shouldEraseSegment {
                    // Finalize the current segment if it's not empty
                    if !currentSegmentPoints.isEmpty {
                        currentSegmentPoints.append(lineStart)
                        newLineSegments.append(currentSegmentPoints)
                        currentSegmentPoints = []
                    }
                    isLineRemoved = true
                } else {
                    // Continue building the current segment
                    if currentSegmentPoints.isEmpty {
                        currentSegmentPoints.append(lineStart)
                    }
                    currentSegmentPoints.append(lineEnd)
                }
            }
            
            // Add the last segment if it wasn't erased
            if !currentSegmentPoints.isEmpty {
                newLineSegments.append(currentSegmentPoints)
            }
            
            // Record the removed line for undo/redo tracking
            if isLineRemoved {
                removedLines.append(line)
            }
            
            // Add new line segments to the collection
            for segmentPoints in newLineSegments {
                if segmentPoints.count > 1 {
                    newLines.append(Line(points: segmentPoints, color: line.color, lineWidth: line.lineWidth, lineType: line.lineType))
                }
            }
        }
        
        // Update the current layer with the new segmented lines
        currentLayer = newLines
    }
    
    // MARK: - Geometry Utility Functions
    
    /// Checks if two line segments intersect within a given radius, used for erasing interactions.
    private func segmentsIntersect(
        _ p1: CGPoint, _ p2: CGPoint,
        _ q1: CGPoint, _ q2: CGPoint,
        eraserRadius: CGFloat
    ) -> Bool {
        let distance = minDistanceBetweenLineSegments(p1, p2, q1, q2)
        return distance <= eraserRadius
    }
    
    /// Calculates the minimum distance between two line segments, which is zero if they intersect.
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
    
    /// Determines if two lines intersect based on their endpoints.
    private func linesIntersect(_ p1: CGPoint, _ p2: CGPoint, _ q1: CGPoint, _ q2: CGPoint) -> Bool {
        func ccw(_ a: CGPoint, _ b: CGPoint, _ c: CGPoint) -> Bool {
            return (c.y - a.y)*(b.x - a.x) > (b.y - a.y)*(c.x - a.x)
        }
        
        return (ccw(p1, q1, q2) != ccw(p2, q1, q2)) && (ccw(p1, p2, q1) != ccw(p1, p2, q2))
    }
    
    /// Calculates the distance from a point to a line segment.
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
