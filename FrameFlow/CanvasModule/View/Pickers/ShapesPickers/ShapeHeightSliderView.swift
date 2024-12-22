//
//  ShapeHeightSliderView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/31/24.
//

import SwiftUI

/// A view providing a slider for adjusting the height of shapes on the canvas.
struct ShapeHeightSliderView: View {
    
    /// The view model that controls the state and actions of the canvas.
    @EnvironmentObject var viewModel: CanvasViewModel
    
    // MARK: - Body
    
    /// The main content of the view, featuring a slider for shape height adjustment.
    internal var body: some View {
        ZStack {
            background
            slider
        }
    }
    
    // MARK: - Slider
    
    /// A slider for adjusting the height of shapes, with a custom track image and a predefined range.
    private var slider: some View {
        Slider(value: $viewModel.shapeHeight, in: 50...400)
            .background(
                Image.Panel.Palette.sliderLine
                    .resizable()
                    .frame(height: 10)
            )
            .padding(.horizontal)
            .accentColor(.clear)
            .frame(width: 176, height: 56)
    }
    
    // MARK: - Background
    
    /// Background styling for the slider, with rounded corners, border, and a translucent material effect.
    private var background: some View {
        RoundedRectangle(cornerRadius: 4)
            .foregroundStyle(Color.SupportColors.supportSelection)
            .opacity(0.1)
            .frame(width: 176, height: 56)
        
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.supportBorder, lineWidth: 1)
            )
        
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 4))
            .opacity(0.96)
    }
}

#Preview {
    ShapeHeightSliderView()
        .environmentObject(CanvasViewModel())
}
