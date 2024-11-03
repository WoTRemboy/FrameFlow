//
//  Labels.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/28/24.
//

final class Texts {
    enum OnboardingPage {
        static let skip = "Skip"
        static let next = "Next page"
        static let started = "Get started"
        
        static let firstTitle = "Frame Flow"
        static let firstDescription = "Create your frame-by-frame animation."
        static let secondTitle = "Draw a masterpiece"
        static let secondDescription = "Use tools to create an image on canvas."
        static let thirdTitle = "Create animation"
        static let thirdDescription = "View the result in the internal player."
        static let fourthTitle = "Share with friends!"
        static let fourthDescription = "Send the GIF to various messengers."
    }
    
    enum LayerSheet {
        static let title = "Storyboard"
        static let done = "Done"
        static let frame = "Frame"
        static let add = "Add frame"
    }
    
    enum AnimationOverlay {
        static let title = "Animation Speed"
        static let units = "sec/frame"
        static let done = "Done"
    }
    
    enum ContextMenu {
        static let speed = "Change speed"
        static let gif = "Share GIF"
        static let copy = "Copy frame"
        static let delete = "Delete all frames"
    }
    
    enum UserDefaults {
        static let firstLaunch = "firstLaunch"
    }
}
