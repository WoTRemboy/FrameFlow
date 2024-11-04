//
//  FrameFlowApp.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/28/24.
//

import SwiftUI

/// The main entry point for the FrameFlow application.
@main
struct FrameFlowApp: App {
    /// The main scene containing the root view of the application.
    ///
    /// The app starts by displaying the `SplashScreenView` as the initial view.
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
}
