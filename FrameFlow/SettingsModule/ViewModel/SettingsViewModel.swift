//
//  SettingsViewModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 12/31/24.
//

import Foundation
import SwiftUI

final class SettingsViewModel: ObservableObject {

    @Published internal var showingLanguageAlert: Bool = false
    @Published internal var showingSpeedOverlay: Bool = false
    
    @Published private(set) var version: String = String()
    
    @AppStorage(Texts.UserDefaults.animationSpeed) var animationSpeed: Double = 0.1
    @Published internal var speed: Double
    
    init(speed: Double) {
        self.speed = speed
        versionDetect()
    }
    
    internal func showSpeedOverlayToggle() {
        withAnimation(.easeInOut(duration: 0.2)) {
            showingSpeedOverlay.toggle()
        }
    }
    
    internal func showLanguageAlertToggle() {
        showingLanguageAlert.toggle()
    }
    
    internal func setSpeed(to value: Double) {
        withAnimation(.easeInOut(duration: 0.2)) {
            animationSpeed = value
        }
    }
    
    private func versionDetect() {
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
           let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            version = "\(appVersion) \(Texts.Settings.release) \(buildVersion)"
        }
    }
}
