//
//  WidthSliderView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/31/24.
//

import SwiftUI

/// A view that provides a slider to adjust the line width for drawing on the canvas.
struct WidthSliderView: View {
    
    /// The view model that controls the state and actions of the canvas.
    @EnvironmentObject var viewModel: CanvasViewModel
    
    // MARK: - Body
    
    /// The main content of the width slider view, including the slider and background styling.
    internal var body: some View {
        ZStack {
            background
            slider
        }
    }
    
    // MARK: - Slider Control
    
    /// The slider for selecting the line width, ranging from 1 to 20.
    private var slider: some View {
        Slider(value: $viewModel.lineWidth, in: 1...20)
            .background(
                Image.Panel.Palette.sliderLine
                    .resizable()
                    .frame(height: 10)
            )
            .padding(.horizontal)
            .accentColor(.clear)
            .frame(width: 256, height: 56)
    }
    
    // MARK: - Background
    
    /// The background styling for the slider, including a rounded rectangle and border.
    private var background: some View {
        RoundedRectangle(cornerRadius: 4)
            .foregroundStyle(Color.SupportColors.supportSelection)
            .opacity(0.1)
            .frame(width: 256, height: 56)
        
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.supportBorder, lineWidth: 1)
            )
        
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 4))
            .opacity(0.96)
    }
}

// MARK: - Preview

#Preview {
    WidthSliderView()
        .environmentObject(CanvasViewModel())
}
