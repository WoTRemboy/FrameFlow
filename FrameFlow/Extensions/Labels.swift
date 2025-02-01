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
        static let fifthTitle = NSLocalizedString("OnboardingPageFifthTitle", comment: "Context menus")
        static let fifthDescription = NSLocalizedString("OnboardingPageFifthDescription", comment: "Use context menus to find these features.")
    }
    
    // MARK: - Layer sheet Texts
    
    enum LayerSheet {
        static let title = NSLocalizedString("LayerSheetTitle", comment: "Storyboard")
        static let done = NSLocalizedString("LayerSheetDone", comment: "Done")
        static let frame = NSLocalizedString("LayerSheetFrame", comment: "Frame")
        static let add = NSLocalizedString("LayerSheetAdd", comment: "Add frame")
    }
    
    // MARK: - Generate params Texts
    
    enum GenerateParams {
        static let title = NSLocalizedString("GenerateParamsTitle", comment: "Generate Parameters")
        static let shapeSelected = NSLocalizedString("GenerateParamsShapeSelected", comment: "Shape selected")
        static let framesCount = NSLocalizedString("GenerateParamsFramesCount", comment: "Frames count")
        static let done = NSLocalizedString("GenerateParamsShapeDone", comment: "Done")
        static let cancel = NSLocalizedString("GenerateParamsShapeCancel", comment: "Cancel")
        
        static let shape = NSLocalizedString("GenerateParamsShape", comment: "Shape")
        static let triangle = NSLocalizedString("GenerateParamsTriangle", comment: "Triangle")
        static let square = NSLocalizedString("GenerateParamsSquare", comment: "Square")
        static let circle = NSLocalizedString("GenerateParamsCircle", comment: "Circle")
        static let arrow = NSLocalizedString("GenerateParamsArrow", comment: "Arrow")
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
    
    enum CreatingGif {
        static let title = NSLocalizedString("ContextMenuCreatingGif", comment: "Creating GIF")
        static let notCreatedGif = NSLocalizedString("CreatingGifNotCreateGif", comment: "Restriction")
        static let notCreatedDescription = NSLocalizedString("CreatingGifNotCreatedDescription", comment: "100 frames is maximum.")
        static let ok = NSLocalizedString("CreatingGifOk", comment: "OK")
        static let cancel = NSLocalizedString("CreatingGifCancel", comment: "Cancel")
    }
    
    // MARK: - Settings Texts
    
    enum Settings {
        static let title = NSLocalizedString("SettingsTitle", comment: "Settings")
        static let cancel = NSLocalizedString("SettingsCancel", comment: "Cancel")
        
        static let about = NSLocalizedString("SettingsAbout", comment: "About")
        static let release = "release"
        static let appName = NSLocalizedString("SettingsAppName", comment: "Frame Flow")
        
        static let content = NSLocalizedString("SettingsContent", comment: "Content")
        static let speed = NSLocalizedString("SettingsSpeed", comment: "Animation Speed")
        
        static let application = NSLocalizedString("SettingsApplication", comment: "Application")
        
        static let contact = NSLocalizedString("SettingsContact", comment: "Contact")
        static let emailTitle = NSLocalizedString("SettingsEmailTitle", comment: "Email")
        static let emailContent = "tverpokhdeb@icloud.com"
        
        enum Language {
            static let title = NSLocalizedString("SettingsLanguageTitle", comment: "Language")
            static let details = NSLocalizedString("SettingsLanguageDetails", comment: "English")
            static let alertTitle = NSLocalizedString("SettingsLanguageAlertTitle", comment: "Change language")
            static let alertContent = NSLocalizedString("SettingsLanguageAlertContent", comment: "Select the language you want in Settings.")
        }
        
        enum Appearance {
            static let title = NSLocalizedString("SettingsAppearanceTitle", comment: "Appearance")
            static let system = NSLocalizedString("SettingsAppearanceSystem", comment: "System")
            static let light = NSLocalizedString("SettingsAppearanceLight", comment: "Light")
            static let dark = NSLocalizedString("SettingsAppearanceDark", comment: "Dark")
        }
    }
    
    // MARK: - UserDefaults Keys
    
    enum UserDefaults {
        static let firstLaunch = "firstLaunch"
        static let animationSpeed = "animationSpeed"
        static let theme = "userTheme"
    }
}
