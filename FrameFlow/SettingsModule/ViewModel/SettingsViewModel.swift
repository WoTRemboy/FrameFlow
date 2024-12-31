//
//  SettingsViewModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 12/31/24.
//

import Foundation
import SwiftUI

final class SettingsViewModel: ObservableObject {
    
    @Published private(set) var version: String = String()
    
    internal func dataUpdate() {
        versionDetect()
    }
    
    private func versionDetect() {
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
           let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            version = "\(appVersion) \(Texts.Settings.release) \(buildVersion)"
        }
    }
}
