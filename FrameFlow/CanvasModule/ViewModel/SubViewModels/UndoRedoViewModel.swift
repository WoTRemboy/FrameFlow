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
        case .addLine(let line):
            lines.removeAll { $0 == line }
            withAnimation(.easeInOut(duration: 0.2)) {
                redoStack.append(lastAction)
            }
            
        case .removeLine(let originalLines):
            lines = originalLines
            withAnimation(.easeInOut(duration: 0.2)) {
                redoStack.append(lastAction)
            }
            
        case .addShape(let shapeLines):
            lines.removeAll { shapeLines.contains($0) }
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
        case .addLine(let line):
            lines.append(line)
            withAnimation(.easeInOut(duration: 0.2)) {
                undoStack.append(lastUndoneAction)
            }
            
        case .removeLine(let originalLines):
            lines = originalLines
            withAnimation(.easeInOut(duration: 0.2)) {
                undoStack.append(lastUndoneAction)
            }
            
        case .addShape(let shapeLines):
            lines.append(contentsOf: shapeLines)
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
