//
//  SettingsViewModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 12/31/24.
//

import Foundation
import SwiftUI

/// A view model that manages the application's settings, including theme, animation speed, and language options.
final class SettingsViewModel: ObservableObject {
    
    // MARK: - Published Properties

    /// Indicates whether the language alert is currently shown in the UI.
    @Published internal var showingLanguageAlert: Bool = false
    /// Indicates whether the speed adjustment overlay is visible.
    @Published internal var showingSpeedOverlay: Bool = false
    
    /// Stores the app version information for display in the settings.
    @Published private(set) var version: String = String()
    /// A local property for holding animation speed, used before committing changes to `AppStorage`.
    @Published internal var speed: Double
    
    // MARK: - AppStorage Properties
    
    /// The user's preferred animation speed, persisted in `AppStorage`.
    @AppStorage(Texts.UserDefaults.animationSpeed) var animationSpeed: Double = 0.1
    /// The user's preferred theme, persisted in `AppStorage`.
    @AppStorage(Texts.UserDefaults.theme) var userTheme: Theme = .systemDefault
    
    // MARK: - Initialization
    
    /// Initializes the settings view model with a default or provided speed value.
    /// - Parameter speed: The initial animation speed before storing it in `AppStorage`.
    init(speed: Double) {
        self.speed = speed
        versionDetect()
    }
    
    // MARK: - UI Toggles
    
    /// Toggles the visibility of the animation speed overlay with an animation.
    internal func showSpeedOverlayToggle() {
        withAnimation(.easeInOut(duration: 0.2)) {
            showingSpeedOverlay.toggle()
        }
    }
    
    /// Toggles the visibility of the language alert.
    internal func showLanguageAlertToggle() {
        showingLanguageAlert.toggle()
    }
    
    // MARK: - Speed Management
    
    /// Sets the animation speed to a new value, with a smooth animation.
    /// - Parameter value: The new animation speed to apply.
    internal func setSpeed(to value: Double) {
        withAnimation(.easeInOut(duration: 0.2)) {
            animationSpeed = value
        }
    }
    
    // MARK: - Theme Management
    
    /// Changes the application's theme, and triggers a smooth transition for the UI.
    /// - Parameter theme: The selected `Theme` to apply.
    internal func changeTheme(theme: Theme) {
        self.userTheme = theme
        
        // Apply the new UI style with a transition effect
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
                    UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        window.overrideUserInterfaceStyle = theme.userInterfaceStyle
                    })
                }
            }
        }
    }
    
    // MARK: - Version Detection
    
    /// Fetches version and build information from the app bundle to display in settings.
    private func versionDetect() {
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
           let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            version = "\(appVersion) \(Texts.Settings.release) \(buildVersion)"
        }
    }
}
