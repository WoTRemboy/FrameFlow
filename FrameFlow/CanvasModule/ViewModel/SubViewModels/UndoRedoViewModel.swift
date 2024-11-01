//
//  UndoRedoViewModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 11/1/24.
//

import SwiftUI

extension CanvasViewModel {
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
