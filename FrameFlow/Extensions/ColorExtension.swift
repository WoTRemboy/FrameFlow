//
//  ColorExtension.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/28/24.
//

import SwiftUI

extension Color {
    
    // MARK: - Back Colors
    
    enum BackColors {
        static let backElevated = Color("BackElevated")
        static let backiOSPrimary = Color("BackiOSPrimary")
        static let backPrimary = Color("BackPrimary")
        static let backSecondary = Color("BackSecondary")
        static let backSplash = Color("BackSplash")
        static let backPopup = Color("BackPopup")
        static let backDefault = Color("BackDefault")
    }
    
    // MARK: - Label Colors
    
    enum LabelColors {
        static let labelDisable = Color("LabelDisable")
        static let labelDetails = Color("LabelDetails")
        static let labelPrimary = Color("LabelPrimary")
        static let labelSecondary = Color("LabelSecondary")
        static let labelTertiary = Color("LabelTertiary")
    }
    
    // MARK: - Palette Colors
    
    enum PaletteColors {
        static let blackPalette = Color("BlackPalette")
        static let bluePalette = Color("BluePalette")
        static let greenPalette = Color("GreenPalette")
        static let greyPalette = Color("GreyPalette")
        static let redPalette = Color("RedPalette")
        static let whitePalette = Color("WhitePalette")
    }
    
    // MARK: - Support Colors
    
    enum SupportColors {
        static let supportNavBar = Color("SupportNavBar")
        static let supportBorder = Color("SupportBorder")
        static let supportIconBorder = Color("SupportIconBorder")
        static let supportSelection = Color("SupportSelection")
        static let supportOverlay = Color("SupportOverlay")
        static let supportSegmented = Color("SupportSegmented")
        static let supportTextField = Color("SupportTextField")
    }
    
    // MARK: - Tint Colors
    
    enum Tints {
        static let orange = Color("OrangeTint")
        static let green = Color("GreenTint")
        static let blue = Color("BlueTint")
    }
}
