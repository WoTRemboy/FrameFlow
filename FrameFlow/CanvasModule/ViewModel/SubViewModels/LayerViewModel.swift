//
//  LayerViewModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 11/1/24.
//

import Foundation
import SwiftUI

extension CanvasViewModel {
    
    /// Checks if the layer list is empty or only contains a single layer.
    /// - Returns: `true` if there is only one or no layers, otherwise `false`.
    internal func isLayersEmpty() -> Bool {
        layers.count <= 1
    }
    
    // MARK: - Adding Layers
    
    /// Adds a new layer after the current layer and makes it the active layer.
    internal func addLayer() {
        layers.insert([], at: currentLayerIndex + 1)
        undoStack.append(Action(type: .addLayer))
        redoStack.removeAll()
        currentLayerIndex += 1
    }
    
    /// Adds a new layer to the end of the layer list and sets it as the active layer.
    internal func addLayerToEnd() {
        layers.append([])
        undoStack.append(Action(type: .addLayerToEnd))
        redoStack.removeAll()
        currentLayerIndex = layers.count - 1
    }
    
    // MARK: - Duplicating Layers
    
    /// Creates a duplicate of the current layer and inserts it directly after the original.
    internal func duplicateCurrentLayer() {
        guard currentLayerIndex >= 0 && currentLayerIndex < layers.count else { return }
        
        let copiedLayer = layers[currentLayerIndex]
        let newLayerIndex = currentLayerIndex + 1
        
        layers.insert(copiedLayer, at: newLayerIndex)
        undoStack.append(Action(type: .duplicateLayer(originalIndex: currentLayerIndex, duplicatedIndex: newLayerIndex)))
        redoStack.removeAll()
        
        currentLayerIndex = newLayerIndex
    }
    
    // MARK: - Deleting Layers
    
    /// Deletes the current layer if there is more than one layer available.
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
    
    /// Deletes a layer at a specific index and updates the current layer index if necessary.
    /// - Parameter index: The index of the layer to be deleted.
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
    
    /// Deletes multiple layers based on specified offsets.
    /// - Parameter offsets: The indices of layers to be deleted.
    internal func deleteLayers(at offsets: IndexSet) {
        offsets.forEach { index in
            withAnimation {
                deleteLayer(at: index)
            }
        }
    }
    
    /// Deletes all layers, resetting the view to a single empty layer.
    internal func deleteAllLayers() {
        guard !layers.isEmpty else { return }
        
        let previousLayers = layers
        
        layers = [[]]
        currentLayerIndex = 0
        
        undoStack.append(Action(type: .removeAllLayers(previousLayers: previousLayers)))
        redoStack.removeAll()
    }
    
    // MARK: - Layer Switching

    /// Switches the active layer to a specified index, allowing animation layers to revert back to the last index after playback.
    /// - Parameters:
    ///   - index: The target layer index to switch to.
    ///   - fromAnimation: If `true`, the switch does not add an action to the undo stack.
    internal func switchToLayer(at index: Int, fromAnimation: Bool = false) {
        guard index >= 0 && index < layers.count, index != currentLayerIndex else { return }
        let previousIndex = fromAnimation ? lastLayerIndex : currentLayerIndex
        currentLayerIndex = index
        
        if lastLayerIndex != index {
            undoStack.append(Action(type: .switchLayer(from: previousIndex, to: index)))
            redoStack.removeAll()
        }
    }
    
    // MARK: - Layer Miniatures
    
    
    /// Generates a miniature image of a specified layer for display, with a white background if the layer is empty.
    /// - Parameters:
    ///   - index: The index of the layer for which the miniature is generated.
    ///   - size: The size of the miniature image.
    /// - Returns: A SwiftUI `Image` representing the layer’s content or a blank placeholder if it fails.
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
    
    /// Generates a blank white image, used as a placeholder when a layer has no content.
    /// - Parameter size: The size of the generated image.
    /// - Returns: A `UIImage` filled with white color.
    private func generateWhiteImage(size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            UIColor.white.setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
    }
}
