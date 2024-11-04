//
//  LayerViewModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 11/1/24.
//

import Foundation
import SwiftUI

extension CanvasViewModel {
    internal func isLayersEmpty() -> Bool {
        layers.count <= 1
    }
    
    internal func addLayer() {
        layers.insert([], at: currentLayerIndex + 1)
        undoStack.append(Action(type: .addLayer))
        redoStack.removeAll()
        currentLayerIndex += 1
    }
    
    internal func addLayerToEnd() {
        layers.append([])
        undoStack.append(Action(type: .addLayerToEnd))
        redoStack.removeAll()
        currentLayerIndex = layers.count - 1
    }
    
    internal func duplicateCurrentLayer() {
        guard currentLayerIndex >= 0 && currentLayerIndex < layers.count else { return }
        
        let copiedLayer = layers[currentLayerIndex]
        let newLayerIndex = currentLayerIndex + 1
        
        layers.insert(copiedLayer, at: newLayerIndex)
        undoStack.append(Action(type: .duplicateLayer(originalIndex: currentLayerIndex, duplicatedIndex: newLayerIndex)))
        redoStack.removeAll()
        
        currentLayerIndex = newLayerIndex
    }

    internal func deleteCurrentLayer() {
        guard layers.count > 1 else { return }
        let removedLines = layers[currentLayerIndex]
        undoStack.append(Action(type: .removeLayer(layerIndex: currentLayerIndex, removedLines: removedLines)))
        redoStack.removeAll()
        
        layers.remove(at: currentLayerIndex)
        if currentLayerIndex >= layers.count {
            currentLayerIndex = layers.count - 1
        }
    }
    
    internal func deleteLayer(at index: Int) {
        guard layers.count > 1 else { return }
        
        let removedLines = layers[index]
        undoStack.append(Action(type: .removeLayer(layerIndex: index, removedLines: removedLines)))
        redoStack.removeAll()
        
        layers.remove(at: index)
        
        if currentLayerIndex >= layers.count {
            currentLayerIndex = layers.count - 1
        } else if currentLayerIndex > index {
            currentLayerIndex -= 1
        }
    }
    
    internal func deleteLayers(at offsets: IndexSet) {
        offsets.forEach { index in
            withAnimation {
                deleteLayer(at: index)
            }
        }
    }
    
    internal func deleteAllLayers() {
        guard !layers.isEmpty else { return }
        
        let previousLayers = layers
        
        layers = [[]]
        currentLayerIndex = 0
        
        undoStack.append(Action(type: .removeAllLayers(previousLayers: previousLayers)))
        redoStack.removeAll()
    }

    internal func switchToLayer(at index: Int, fromAnimation: Bool = false) {
        guard index >= 0 && index < layers.count, index != currentLayerIndex else { return }
        let previousIndex = fromAnimation ? lastLayerIndex : currentLayerIndex
        currentLayerIndex = index
        
        if lastLayerIndex != index {
            undoStack.append(Action(type: .switchLayer(from: previousIndex, to: index)))
            redoStack.removeAll()
        }
    }
    
    @MainActor internal func miniatureForLayer(at index: Int, size: CGSize = CGSize(width: 50, height: 85)) -> Image {
        let layer = layers[index]
        
        if layer.isEmpty {
            return Image(uiImage: generateWhiteImage(size: size))
        }
        
        let renderer = ImageRenderer(content: LayerMiniatureView(lines: layer)
            .frame(width: size.width, height: size.height)
            .scaleEffect(0.8)
        )

        if let uiImage = renderer.uiImage {
            return Image(uiImage: uiImage)
        } else {
            return Image.LayerSheet.xmark
        }
    }
    
    private func generateWhiteImage(size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            UIColor.white.setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
    }
}
