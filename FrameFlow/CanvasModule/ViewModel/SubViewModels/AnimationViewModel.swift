//
//  AnimationViewModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 11/3/24.
//

import Foundation
import SwiftUI

extension CanvasViewModel {
    
    // MARK: - Start Animation
    
    /// Begins the animation sequence, cycling through each layer at a specified speed.
    internal func startAnimation() {
        guard layers.count > 1, !isAnimating else { return }
        
        // Save the current layer index for later restoration
        lastLayerIndex = currentLayerIndex
        
        withAnimation(.easeInOut(duration: 0.2)) {
            isAnimating = true
            showShapePicker = false
            showColorPicker = false
        }
        
        // Start a timer to trigger the next frame at the specified speed
        animationCancellable = Timer.publish(every: animationSpeed, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.nextFrame()
            }
    }
    
    // MARK: - Stop Animation
    
    /// Stops the animation sequence and restores the layer view to the last available layer.
    internal func stopAnimation() {
        withAnimation(.easeInOut(duration: 0.2)) {
            isAnimating = false
        }
        animationCancellable?.cancel()
        animationCancellable = nil
        
        // Switch to the last layer after stopping animation
        if !layers.isEmpty, currentLayerIndex != layers.count - 1 {
            switchToLayer(at: layers.count - 1, fromAnimation: true)
            lastLayerIndex = currentLayerIndex
        }
    }
    
    // MARK: - Frame Transition
    
    /// Advances to the next frame in the animation sequence.
    private func nextFrame() {
        currentLayerIndex = (currentLayerIndex + 1) % layers.count
        if !isAnimating { stopAnimation() }
    }
}
