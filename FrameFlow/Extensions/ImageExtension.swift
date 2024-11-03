//
//  ImageExtension.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/28/24.
//

import SwiftUI

extension Image {
    enum Header {
        enum Arrows {
            static let leftActive = Image("LeftActive")
            static let leftInactive = Image("LeftInactive")
            static let rightActive = Image("RightActive")
            static let rightInactive = Image("RightInactive")
        }
        
        enum Modifiers {
            static let bin = Image("Bin")
            static let binInactive = Image("BinInactive")
            static let filePlus = Image("FilePlus")
            static let layers = Image("Layers")
        }
        
        enum Player {
            static let pauseActive = Image("PauseActive")
            static let pauseInactive = Image("PauseInactive")
            static let playActive = Image("PlayActive")
            static let playInactive = Image("PlayInactive")
        }
    }
    
    enum Panel {
        enum Palette {
            static let paletteInactive = Image("PaletteInactive")
            static let paletteSelected = Image("PaletteSelected")
            static let sliderLine = Image("SliderLine")
        }
        
        enum Shapes {
            static let arrowUp = Image("ArrowUp")
            static let cicle = Image("Circle")
            static let square = Image("Square")
            static let triangle = Image("Triangle")
        }
    }
    
    enum TabBar {
        static let brushInactive = Image("BrushInactive")
        static let brushSelected = Image("BrushSelected")
        
        static let eraseInactive = Image("EraseInactive")
        static let eraseSelected = Image("EraseSelected")
        
        static let instrumentsInactive = Image("InstrumentsInactive")
        static let instrumentsSelected = Image("InstrumentsSelected")
        
        static let pencilInactive = Image("PencilInactive")
        static let pencilSelected = Image("PencilSelected")
    }
    
    enum Canvas {
        static let canvas = Image("Canvas")
    }
    
    enum LayerSheet {
        static let fill = Image(systemName: "checkmark.circle.fill")
        static let circle = Image(systemName: "circle")
        static let xmark = Image(systemName: "xmark.circle")
    }
    
    enum Opening {
        enum SplashScreen {
            static let splashLogo = Image("SplashLogo")
            static let splashText = Image("SplashText")
        }
        
        enum OnboardingPage {
            static let about = Image("SplashAboutApp")
            static let draw = Image("SplashDrawFrame")
            static let animate = Image("SplashCreateAnimation")
            static let share = Image("SplashShareGif")
        }
    }
}
