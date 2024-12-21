//
//  GenerateFramesViewModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 12/21/24.
//

import Foundation
import SwiftUI

extension CanvasViewModel {
    /// Generates a sequence of frames, adds them to new layers, and returns an array of layers.
    /// - Parameters:
    ///   - shape: The shape type to animate.
    ///   - frameCount: The number of frames to generate.
    ///   - canvasSize: The size of the canvas.
    private func generateFramesWithLayers(
        shape: ShapeMode,
        frameCount: Int,
        canvasSize: CGSize
    ) {
        guard frameCount > 0 else { return }
        deleteAllLayers()
        
        // Initial parameters for the shape
        var startPosition = CGPoint(
            x: CGFloat.random(in: 50..<canvasSize.width - 50),
            y: CGFloat.random(in: 50..<canvasSize.height - 50)
        )
        var endPosition = CGPoint(
            x: CGFloat.random(in: 50..<canvasSize.width - 50),
            y: CGFloat.random(in: 50..<canvasSize.height - 50)
        )
        var startAngle: CGFloat = .random(in: 0..<2 * .pi)
        var endAngle: CGFloat = .random(in: 0..<2 * .pi)
        
        var startScale = CGSize(width: 1.0, height: 1.0)
        var endScale = CGSize(
            width: CGFloat.random(in: 0.5..<2.0),
            height: CGFloat.random(in: 0.5..<2.0)
        )
        
        let step = 50 // Number of frames in a series
        var currentIndex = 0
        
        while currentIndex < frameCount {
            let endIndexInSeries = min(frameCount, currentIndex + step)
            let framesInSeries = endIndexInSeries - currentIndex
            currentIndex = endIndexInSeries
            
            // Movement vector
            let vector = CGPoint(
                x: endPosition.x - startPosition.x,
                y: endPosition.y - startPosition.y
            )
            
            for i in 0..<framesInSeries {
                let progress = CGFloat(i) / CGFloat(framesInSeries)
                
                // Calculate position of the shape
                let position = CGPoint(
                    x: startPosition.x + progress * vector.x,
                    y: startPosition.y + progress * vector.y
                )
                
                // Calculate rotation angle
                let rotation = startAngle + (endAngle - startAngle) * progress
                
                // Calculate shape scale
                let scale = CGSize(
                    width: startScale.width + (endScale.width - startScale.width) * progress,
                    height: startScale.height + (endScale.height - startScale.height) * progress
                )
                
                // Generate lines for the frame
                let lines = createPreviewLinesForShape(
                    shape,
                    at: position,
                    size: CGSize(
                        width: scale.width * 100,
                        height: scale.height * 100
                    ),
                    rotation: rotation
                )
                finalizeShape()
                
                // Add the frame as a layer
                layers.append(lines)
            }
            
            // Update parameters for the next series
            startPosition = endPosition
            startAngle = endAngle
            startScale = endScale
            
            endPosition = CGPoint(
                x: CGFloat.random(in: 50..<canvasSize.width - 50),
                y: CGFloat.random(in: 50..<canvasSize.height - 50)
            )
            endAngle = .random(in: 0..<2 * .pi)
            endScale = CGSize(
                width: CGFloat.random(in: 0.5..<2.0),
                height: CGFloat.random(in: 0.5..<2.0)
            )
        }
        
        // Set the current layer to the last one
        currentLayerIndex = layers.count - 1
    }
    
    /// Generates an animation sequence for a predefined shape, frame count, and canvas size.
    internal func generateAnimationSequence() {
        let shape: ShapeMode = .circle
        let frameCount = 200
        
        generateFramesWithLayers(
            shape: shape,
            frameCount: frameCount,
            canvasSize: canvasSize
        )
    }
}
