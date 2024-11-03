//
//  AnimationViewModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 11/3/24.
//

import Foundation
import SwiftUI

extension CanvasViewModel {
    internal func startAnimation() {
        guard layers.count > 1, !isAnimating else { return }
        
        withAnimation(.easeInOut(duration: 0.2)) {
            isAnimating = true
            showShapePicker = false
            showColorPicker = false
        }
        
        animationCancellable = Timer.publish(every: animationSpeed, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.nextFrame()
            }
    }
    
    internal func stopAnimation() {
        withAnimation(.easeInOut(duration: 0.2)) {
            isAnimating = false
        }
        animationCancellable?.cancel()
        animationCancellable = nil
    }
    
    private func nextFrame() {
        currentLayerIndex = (currentLayerIndex + 1) % layers.count
        if !isAnimating { stopAnimation() }
    }
}
