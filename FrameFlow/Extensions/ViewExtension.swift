//
//  ViewExtension.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/29/24.
//

import SwiftUI

extension View {
    func hasNotch() -> Bool {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let keyWindow = windowScene.windows.first(where: \.isKeyWindow) else {
            return false
        }
        return keyWindow.safeAreaInsets.top > 20
    }
}
