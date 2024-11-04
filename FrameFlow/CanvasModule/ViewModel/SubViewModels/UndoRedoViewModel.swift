//
//  UndoRedoViewModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 11/1/24.
//

import SwiftUI

extension CanvasViewModel {
    
    // MARK: - Undo Functionality
    
    /// Reverts the last action taken by the user.
    internal func undo() {
        guard let lastAction = undoStack.popLast() else { return }
        
        switch lastAction.type {
        case .addLine(let line, let layerIndex):
            layers[layerIndex].removeAll { $0.id == line.id }
            withAnimation(.easeInOut(duration: 0.2)) {
                redoStack.append(lastAction)
            }
            
        case .removeLine(let originalLines, let layerIndex):
            layers[layerIndex] = originalLines
            withAnimation(.easeInOut(duration: 0.2)) {
                redoStack.append(lastAction)
            }
            
        case .addShape(let shapeLines, let layerIndex):
            layers[layerIndex].removeAll { shapeLines.contains($0) }
            withAnimation(.easeInOut(duration: 0.2)) {
                redoStack.append(lastAction)
            }
        case .addLayer:
            layers.remove(at: currentLayerIndex)
            currentLayerIndex -= 1
            withAnimation(.easeInOut(duration: 0.2)) {
                redoStack.append(lastAction)
            }
            
        case .addLayerToEnd:
            layers.removeLast()
            currentLayerIndex = layers.count - 1
            withAnimation(.easeInOut(duration: 0.2)) {
                redoStack.append(lastAction)
            }
            
            
        case .removeLayer(let layerIndex, let removedLines):
            layers.insert(removedLines, at: layerIndex)
            currentLayerIndex = layerIndex
            withAnimation(.easeInOut(duration: 0.2)) {
                redoStack.append(lastAction)
            }
            
        case .switchLayer(let from, _):
            currentLayerIndex = from
            withAnimation(.easeInOut(duration: 0.2)) {
                redoStack.append(lastAction)
            }
            
        case .duplicateLayer(let originalIndex, let duplicatedIndex):
            layers.remove(at: duplicatedIndex)
            currentLayerIndex = originalIndex
            withAnimation(.easeInOut(duration: 0.2)) {
                redoStack.append(lastAction)
            }
            
        case .removeAllLayers(let previousLayers):
            layers = previousLayers
            currentLayerIndex = layers.count - 1
            withAnimation(.easeInOut(duration: 0.2)) {
                redoStack.append(lastAction)
            }
        }
    }
    
    /// Checks if there are actions available for undo.
    internal func undoAvailable() -> Bool {
        !undoStack.isEmpty
    }
    
    /// Returns the appropriate image for the undo button, based on availability.
    internal func undoAvailableImage() -> Image {
        if undoStack.isEmpty {
            Image.Header.Arrows.rightInactive
        } else {
            Image.Header.Arrows.rightActive
        }
    }
    
    // MARK: - Redo Functionality
    
    /// Reapplies the last undone action, restoring the user's previous change.
    internal func redo() {
        guard let lastUndoneAction = redoStack.popLast() else { return }
        
        switch lastUndoneAction.type {
        case .addLine(let line, let layerIndex):
            layers[layerIndex].append(line)
            withAnimation(.easeInOut(duration: 0.2)) {
                undoStack.append(lastUndoneAction)
            }
            
        case .removeLine(let originalLines, let layerIndex):
            layers[layerIndex] = originalLines
            withAnimation(.easeInOut(duration: 0.2)) {
                undoStack.append(lastUndoneAction)
            }
            
        case .addShape(let shapeLines, let layerIndex):
            layers[layerIndex].append(contentsOf: shapeLines)
            withAnimation(.easeInOut(duration: 0.2)) {
                undoStack.append(lastUndoneAction)
            }
            
        case .addLayer:
            layers.insert([], at: currentLayerIndex + 1)
            currentLayerIndex += 1
            withAnimation(.easeInOut(duration: 0.2)) {
                undoStack.append(lastUndoneAction)
            }
            
        case .addLayerToEnd:
            layers.append([])
            currentLayerIndex = layers.count - 1
            withAnimation(.easeInOut(duration: 0.2)) {
                undoStack.append(lastUndoneAction)
            }
            
        case .removeLayer(let layerIndex, _):
            layers.remove(at: layerIndex)
            if currentLayerIndex >= layers.count {
                currentLayerIndex = layers.count - 1
            }
            withAnimation(.easeInOut(duration: 0.2)) {
                undoStack.append(lastUndoneAction)
            }
            
        case .switchLayer(_, let to):
            currentLayerIndex = to
            withAnimation(.easeInOut(duration: 0.2)) {
                undoStack.append(lastUndoneAction)
            }
        
        case .duplicateLayer(let originalIndex, let duplicatedIndex):
            let copiedLayer = layers[originalIndex]
            layers.insert(copiedLayer, at: duplicatedIndex)
            currentLayerIndex = duplicatedIndex
            withAnimation(.easeInOut(duration: 0.2)) {
                undoStack.append(lastUndoneAction)
            }
            
        case .removeAllLayers:
            layers = [[]]
            currentLayerIndex = 0
            withAnimation(.easeInOut(duration: 0.2)) {
                undoStack.append(lastUndoneAction)
            }
        }
    }
    
    /// Checks if there are actions available for redo.
    internal func redoAvailable() -> Bool {
        !redoStack.isEmpty
    }
    
    /// Returns the appropriate image for the redo button, based on availability.
    internal func redoAvailableImage() -> Image {
        if redoStack.isEmpty {
            Image.Header.Arrows.leftInactive
        } else {
            Image.Header.Arrows.leftActive
        }
    }
}
