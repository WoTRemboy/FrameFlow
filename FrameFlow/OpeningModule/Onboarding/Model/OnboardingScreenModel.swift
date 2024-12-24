//
//  OnboardingScreenModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/30/24.
//

import SwiftUI

/// Represents a step in the onboarding process, including title, description, and image.
struct OnboardingStep {
    /// Title of the onboarding step.
    let name: String
    /// Description of what this step covers.
    let description: String
    /// Image associated with this onboarding step.
    let image: Image
}

extension OnboardingStep {
    
    /// Configures and returns the list of onboarding steps.
    /// - Returns: An array of `OnboardingStep` instances, each representing a step in the onboarding process.
    static func stepsSetup() -> [OnboardingStep] {
        let first = OnboardingStep(name: Texts.OnboardingPage.firstTitle,
                                   description: Texts.OnboardingPage.firstDescription,
                                   image: Image.Opening.OnboardingPage.about)
        
        let second = OnboardingStep(name: Texts.OnboardingPage.secondTitle,
                                    description: Texts.OnboardingPage.secondDescription,
                                    image: Image.Opening.OnboardingPage.draw)
        
        let third = OnboardingStep(name: Texts.OnboardingPage.thirdTitle,
                                   description: Texts.OnboardingPage.thirdDescription,
                                   image: Image.Opening.OnboardingPage.animate)
        
        let fourth = OnboardingStep(name: Texts.OnboardingPage.fourthTitle,
                                    description: Texts.OnboardingPage.fourthDescription,
                                    image: Image.Opening.OnboardingPage.share)
        
        return [first, second, third, fourth]
    }
}

// MARK: - OnboardingButtonType

/// Enum defining types of buttons in the onboarding screen.
enum OnboardingButtonType {
    /// Button that navigates to the next onboarding step.
    case nextPage
    /// Button that completes onboarding and starts the app.
    case getStarted
}
