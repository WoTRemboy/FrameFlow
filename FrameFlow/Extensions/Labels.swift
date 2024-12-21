//
//  Labels.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/28/24.
//

import Foundation

final class Texts {
    
    // MARK: - Onboarding Texts
    
    enum OnboardingPage {
        static let skip = NSLocalizedString("OnboardingPageSkip", comment: "Skip")
        static let next = NSLocalizedString("OnboardingPageNextPage", comment: "Next page")
        static let started = NSLocalizedString("OnboardingPageStarted", comment: "Get started")
        
        static let firstTitle = "Frame Flow"
        static let firstDescription = NSLocalizedString("OnboardingPageFirstDescription", comment: "Create your frame-by-frame animation.")
        static let secondTitle = NSLocalizedString("OnboardingPageSecondTitle", comment: "Draw a masterpiece")
        static let secondDescription = NSLocalizedString("OnboardingPageSecondDescription", comment: "Use tools to create an image on canvas.")
        static let thirdTitle = NSLocalizedString("OnboardingPageThirdTitle", comment: "Create animation")
        static let thirdDescription = NSLocalizedString("OnboardingPageThirdDescription", comment: "View the result in the internal player.")
        static let fourthTitle = NSLocalizedString("OnboardingPageFourthTitle", comment: "Share with friends!")
        static let fourthDescription = NSLocalizedString("OnboardingPageFourthDescription", comment: "Send the GIF to various messengers.")
    }
    
    // MARK: - Layer sheet Texts
    
    enum LayerSheet {
        static let title = NSLocalizedString("LayerSheetTitle", comment: "Storyboard")
        static let done = NSLocalizedString("LayerSheetDone", comment: "Done")
        static let frame = NSLocalizedString("LayerSheetFrame", comment: "Frame")
        static let add = NSLocalizedString("LayerSheetAdd", comment: "Add frame")
    }
    
    // MARK: - Animation overlay Texts
    
    enum AnimationOverlay {
        static let title = NSLocalizedString("AnimationOverlayTitle", comment: "Animation Speed")
        static let units = NSLocalizedString("AnimationOverlayUnits", comment: "sec/frame")
        static let done = NSLocalizedString("AnimationOverlayDone", comment: "Done")
    }
    
    // MARK: - Context menu Texts
    
    enum ContextMenu {
        static let play = NSLocalizedString("ContextMenuPlay", comment: "Play animation")
        static let speed = NSLocalizedString("ContextMenuSpeed", comment: "Change speed")
        static let gif = NSLocalizedString("ContextMenuGIF", comment: "Share GIF")
        
        static let add = NSLocalizedString("ContextMenuAdd", comment: "Add frame")
        static let copy = NSLocalizedString("ContextMenuCopy", comment: "Copy frame")
        static let generate = NSLocalizedString("ContextMenuGenerate", comment: "Generate frames")
        
        static let delete = NSLocalizedString("ContextMenuDeleteCurrent", comment: "Delete frame")
        static let deleteAll = NSLocalizedString("ContextMenuDelete", comment: "Delete all frames")
        static let color = NSLocalizedString("ContextMenuColor", comment: "Select the color")
    }
    
    // MARK: - UserDefaults Keys
    
    enum UserDefaults {
        static let firstLaunch = "firstLaunch"
    }
}
