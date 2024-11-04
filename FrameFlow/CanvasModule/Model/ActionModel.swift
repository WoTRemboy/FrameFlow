//
//  ActionModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/31/24.
//

// MARK: - Action

/// Represents an action taken by the user within the FrameFlow app, which can be undone or redone.
struct Action {
    /// The type of action, describing the specific operation and the data associated with it.
    let type: ActionType
}

// MARK: - ActionType

/// Defines the types of actions that can be taken on the canvas, particularly those affecting layers and lines.
enum ActionType {
    
    // MARK: Line Actions
    
    /// Adds a single line to a specified layer.
    /// - Parameters:
    ///   - line: The `Line` object to be added.
    ///   - layerIndex: The index of the layer where the line should be added.
    case addLine(Line, layerIndex: Int)
    
    /// Removes specific lines from a specified layer.
    /// - Parameters:
    ///   - lines: An array of `Line` objects that were removed.
    ///   - layerIndex: The index of the layer from which lines were removed.
    case removeLine([Line], layerIndex: Int)
    
    /// Adds multiple lines that represent a shape to a specified layer.
    /// - Parameters:
    ///   - shapeLines: An array of `Line` objects forming the shape.
    ///   - layerIndex: The index of the layer where the shape is added.
    case addShape([Line], layerIndex: Int)
    
    // MARK: Layer Actions
    
    /// Adds a new layer at the current position.
    case addLayer
    /// Adds a new layer at the end of all layers.
    case addLayerToEnd
    
    /// Removes an entire layer, including all lines within it.
    /// - Parameters:
    ///   - layerIndex: The index of the layer to be removed.
    ///   - removedLines: The lines contained within the removed layer.
    case removeLayer(layerIndex: Int, removedLines: [Line])
    
    /// Switches the current editing layer from one to another.
    /// - Parameters:
    ///   - from: The index of the layer being switched from.
    ///   - to: The index of the layer being switched to.
    case switchLayer(from: Int, to: Int)
    
    /// Duplicates an existing layer, creating a new copy.
    /// - Parameters:
    ///   - originalIndex: The index of the original layer.
    ///   - duplicatedIndex: The index where the duplicated layer will be placed.
    case duplicateLayer(originalIndex: Int, duplicatedIndex: Int)
    
    /// Removes all layers, preserving a snapshot of previous layers for potential restoration.
    /// - Parameter previousLayers: A 2D array of `Line` objects representing the state of all layers before removal.
    case removeAllLayers(previousLayers: [[Line]])
}
