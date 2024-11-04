//
//  ActionModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/31/24.
//

struct Action {
    let type: ActionType
}

enum ActionType {
    case addLine(Line, layerIndex: Int)
    case removeLine([Line], layerIndex: Int)
    case addShape([Line], layerIndex: Int)
    case addLayer
    case addLayerToEnd
    case removeLayer(layerIndex: Int, removedLines: [Line])
    case switchLayer(from: Int, to: Int)
    case duplicateLayer(originalIndex: Int, duplicatedIndex: Int)
    case removeAllLayers(previousLayers: [[Line]])
}
