//
//  CanvasViewModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/30/24.
//

import SwiftUI

final class CanvasViewModel: ObservableObject {
    @Published internal var layers: [[Line]] = [[]]
    @Published internal var currentLayerIndex: Int = 0
    
    @Published internal var lines: [Line] = []
    @Published internal var currentLine: Line = Line(points: [], color: .black, lineWidth: 5)
    @Published internal var currentEraserLine: Line = Line(points: [], color: .clear, lineWidth: 5)
    
    @Published internal var lineWidth: CGFloat = 5.0
    @Published internal var shapeHeight: CGFloat = 100.0
    
    @Published internal var currentMode: CanvasMode = .pencil
    @Published internal var selectedColor: Color = .black
    
    @Published internal var shapes: [ShapeItem] = []
    @Published internal var currentShape: ShapeMode? = nil
    @Published internal var tapLocation: CGPoint = .zero
    
    @Published internal var showColorPicker: Bool = false
    @Published internal var showColorPalette: Bool = false
    @Published internal var showShapePicker: Bool = false
    
    @Published internal var undoStack: [Action] = []
    @Published internal var redoStack: [Action] = []
    
    internal var currentLayer: [Line] {
        get {
            layers[currentLayerIndex]
        }
        set {
            layers[currentLayerIndex] = newValue
        }
    }
    
    internal func selectMode(_ mode: CanvasMode) {
        withAnimation(.easeInOut(duration: 0.2)) {
            showColorPicker = false
            showShapePicker = false
            currentMode = mode
        }
    }
    
    internal func toggleColorPicker() {
        withAnimation(.easeInOut(duration: 0.2)) {
            showColorPicker.toggle()
            showShapePicker = false
            currentMode = .palette
        }
    }
    
    internal func toggleColorPalette() {
        withAnimation(.easeInOut(duration: 0.2)) {
            showColorPalette.toggle()
        }
    }
    
    internal func selectColor(_ color: Color) {
        selectedColor = color
    }
    
    internal func selectTabbarImage(targetMode: CanvasMode, currentMode: CanvasMode,
                                    active: Image, inactive: Image) -> Image {
        if targetMode == currentMode {
            return active
        } else {
            return inactive
        }
    }
    
    internal func selectTrueImage(isActive: Bool, active: Image, inactive: Image) -> Image {
        if isActive {
            return active
        } else {
            return inactive
        }
    }
}
