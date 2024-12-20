//
//  CanvasViewModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/30/24.
//

import SwiftUI
import Combine

/// The main view model for managing the canvas, layers, drawing modes, and animations in the FrameFlow application.
final class CanvasViewModel: ObservableObject {
    
    // MARK: - Canvas Properties
    
    /// The array of layers, where each layer contains an array of `Line` objects.
    @Published internal var layers: [[Line]] = [[]]
    /// The index of the currently active layer.
    @Published internal var currentLayerIndex: Int = 0
    /// Tracks the last layer index for reference.
    @Published internal var lastLayerIndex: Int = 0
    /// The size of the canvas, which determines the rendering bounds.
    @Published internal var canvasSize: CGSize = CGSize(width: 0, height: 0)
    
    // MARK: - Shape Properties
        
    /// The initial touch point when starting to draw a shape.
    @Published internal var initialShapePoint: CGPoint = .zero
    /// A preview of the shape being adjusted.
    @Published internal var previewShapeLines: [Line] = []
    
    // MARK: - Animation Properties
    
    /// Indicates whether an animation is currently playing.
    @Published internal var isAnimating = false
    /// Controls the speed of animation playback.
    @Published internal var animationSpeed: Double = 0.1
    
    // MARK: - Drawing Properties
    
    /// Stores the lines currently on the canvas.
    @Published internal var lines: [Line] = []
    /// Represents the current line being drawn.
    @Published internal var currentLine: Line = Line(points: [], color: .black, lineWidth: 5)
    /// Represents the line being erased.
    @Published internal var currentEraserLine: Line = Line(points: [], color: .clear, lineWidth: 5)
    
    /// Defines the width of the drawing tool’s line.
    @Published internal var lineWidth: CGFloat = 5.0
    /// Sets the height for shapes added to the canvas.
    @Published internal var shapeHeight: CGFloat = 100.0
    
    // MARK: - Mode and Color Properties
    
    /// The current mode of the canvas (e.g., pencil, brush, eraser).
    @Published internal var currentMode: CanvasMode = .pencil
    /// The currently selected color for drawing or shapes.
    @Published internal var selectedColor: Color = .black
    
    // MARK: - Shape Properties
    
    /// Stores an array of `ShapeItem` objects representing shapes on the canvas.
    @Published internal var shapes: [ShapeItem] = []
    /// Holds the currently selected shape type.
    @Published internal var currentShape: ShapeMode? = nil
    /// The position where the last tap occurred on the canvas.
    @Published internal var tapLocation: CGPoint = .zero
    
    // MARK: - UI Toggle Properties
    
    /// Controls the visibility of the color picker.
    @Published internal var showColorPicker: Bool = false
    /// Controls the visibility of the color palette.
    @Published internal var showColorPalette: Bool = false
    /// Controls the visibility of the shape picker.
    @Published internal var showShapePicker: Bool = false
    /// Indicates if the layer selection sheet is currently presented.
    @Published internal var isLayerSheetPresented = false
    /// Indicates if the speed overlay for animation is currently visible.
    @Published internal var isSpeedOverlayVisible = false
    
    // MARK: - Undo/Redo Properties
    
    /// Stack for undo actions, storing previous states.
    @Published internal var undoStack: [Action] = []
    /// Stack for redo actions, storing reverted states.
    @Published internal var redoStack: [Action] = []
    
    /// Stores a cancellable reference for controlling animations.
    internal var animationCancellable: AnyCancellable?
    
    // MARK: - Computed Property
    
    /// The currently selected layer as an array of lines.
    internal var currentLayer: [Line] {
        get {
            layers[currentLayerIndex]
        }
        set {
            layers[currentLayerIndex] = newValue
        }
    }
    
    // MARK: - Layer Control Methods
    
    /// Toggles the visibility of the layer sheet.
    internal func toggleLayerSheet() {
        isLayerSheetPresented.toggle()
    }
    
    /// Toggles the visibility of the animation speed overlay with an animation.
    internal func toggleSpeedOverlay() {
        withAnimation(.easeInOut(duration: 0.2)) {
            isSpeedOverlayVisible.toggle()
        }
    }
    
    // MARK: - Selection Methods
    
    /// Selects the drawing mode (e.g., pencil, brush, eraser) and hides color and shape pickers.
    /// - Parameter mode: The selected `CanvasMode`.
    internal func selectMode(_ mode: CanvasMode) {
        withAnimation(.easeInOut(duration: 0.2)) {
            showColorPicker = false
            showShapePicker = false
            currentMode = mode
        }
    }
    
    /// Toggles the visibility of the color picker, setting the mode to palette.
    internal func toggleColorPicker() {
        withAnimation(.easeInOut(duration: 0.2)) {
            showColorPicker.toggle()
            showShapePicker = false
            currentMode = .palette
        }
    }
    
    /// Toggles the visibility of the color palette.
    internal func toggleColorPalette() {
        withAnimation(.easeInOut(duration: 0.2)) {
            showColorPalette.toggle()
        }
    }
        
    /// Sets the selected color for drawing or shapes.
    /// - Parameter color: The new color to be used.
    internal func selectColor(_ color: Color) {
        selectedColor = color
    }
    
    /// Chooses the appropriate image for a tab based on the current mode.
    /// - Parameters:
    ///   - targetMode: The mode associated with the image.
    ///   - currentMode: The currently selected mode.
    ///   - active: The image to display if the mode is active.
    ///   - inactive: The image to display if the mode is inactive.
    /// - Returns: The selected image based on whether the mode is active or inactive.
    internal func selectTabbarImage(targetMode: CanvasMode, currentMode: CanvasMode,
                                    active: Image, inactive: Image) -> Image {
        if targetMode == currentMode {
            return active
        } else {
            return inactive
        }
    }
    
    /// Chooses the appropriate image based on an active or inactive state.
    /// - Parameters:
    ///   - isActive: Whether the item is active.
    ///   - active: The active state image.
    ///   - inactive: The inactive state image.
    /// - Returns: The selected image based on active or inactive state.
    internal func selectTrueImage(isActive: Bool, active: Image, inactive: Image) -> Image {
        if isActive {
            return active
        } else {
            return inactive
        }
    }
}
