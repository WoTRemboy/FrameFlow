//
//  CanvasViewModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/30/24.
//

import SwiftUI

final class CanvasViewModel: ObservableObject {
    @Published internal var lines: [Line] = []
    @Published internal var currentLine: Line = Line(points: [], color: .black, lineWidth: 5)
    @Published internal var lineWidth: CGFloat = 5.0
    
    @Published internal var currentMode: CanvasMode = .pencil
    @Published internal var selectedShape: Shape = .square
    @Published internal var selectedColor: Color = .black
    
    @Published internal var showColorPicker: Bool = false
    @Published internal var showColorPalette: Bool = false
    @Published internal var showShapePicker: Bool = false
    
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
    
    internal func toggleShapePicker() {
        withAnimation(.easeInOut(duration: 0.2)) {
            showShapePicker.toggle()
            showColorPicker = false
            currentMode = .instruments
        }
    }
    
    internal func updateCurrentLine(with point: CGPoint, in size: CGSize) {
        if point.x >= lineWidth / 2, point.x <= size.width - lineWidth / 2,
           point.y >= lineWidth / 2, point.y <= size.height - lineWidth / 2 {
            currentLine.points.append(point)
            currentLine.color = selectedColor
            currentLine.lineWidth = lineWidth
        }
    }
    
    internal func finalizeCurrentLine() {
        lines.append(currentLine)
        currentLine = Line(points: [], color: selectedColor, lineWidth: lineWidth)
    }
    
    internal func selectColor(_ color: Color) {
        selectedColor = color
    }
    
    internal func selectShape(_ shape: Shape) {
        selectedShape = shape
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
