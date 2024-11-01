//
//  LayerViewModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 11/1/24.
//

extension CanvasViewModel {
    internal func addLayer() {
        layers.append([])
        undoStack.append(Action(type: .addLayer))
        redoStack.removeAll()
        currentLayerIndex = layers.count - 1
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

    internal func switchToLayer(at index: Int) {
        guard index >= 0 && index < layers.count, index != currentLayerIndex else { return }
        let previousIndex = currentLayerIndex
        currentLayerIndex = index
        undoStack.append(Action(type: .switchLayer(from: previousIndex, to: index)))
        redoStack.removeAll()
    }
}
