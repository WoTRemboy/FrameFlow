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
    case addLine(Line)
    case addShape([Line])
}
