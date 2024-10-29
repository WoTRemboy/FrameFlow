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
    
    enum Opening {
        static let splashLogo = Image("SplashLogo")
    }
}
