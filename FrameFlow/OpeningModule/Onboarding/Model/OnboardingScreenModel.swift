//
//  OnboardingScreenModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/30/24.
//

import SwiftUI

struct OnboardingStep {
    let name: String
    let description: String
    let image: Image
}

extension OnboardingStep {
    static func stepsSetup() -> [OnboardingStep] {
        let first = OnboardingStep(name: Texts.OnboardingPage.firstTitle,
                                   description: Texts.OnboardingPage.firstDescription,
                                   image: .Opening.about)
        
        let second = OnboardingStep(name: Texts.OnboardingPage.secondTitle,
                                    description: Texts.OnboardingPage.secondDescription,
                                    image: .Opening.draw)
        
        let third = OnboardingStep(name: Texts.OnboardingPage.thirdTitle,
                                   description: Texts.OnboardingPage.thirdDescription,
                                   image: .Opening.animate)
        
        let fourth = OnboardingStep(name: Texts.OnboardingPage.fourthTitle,
                                    description: Texts.OnboardingPage.fourthDescription,
                                    image: .Opening.share)
        
        return [first, second, third, fourth]
    }
}


enum OnboardingButtonType {
    case nextPage
    case getStarted
}
