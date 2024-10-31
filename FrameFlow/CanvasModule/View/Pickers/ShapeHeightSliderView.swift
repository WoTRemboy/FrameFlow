//
//  ShapeHeightSliderView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/31/24.
//

import SwiftUI

struct ShapeHeightSliderView: View {
    
    @EnvironmentObject var viewModel: CanvasViewModel
    
    internal var body: some View {
        ZStack {
            background
            slider
        }
    }
    
    private var slider: some View {
        Slider(value: $viewModel.shapeHeight, in: 10...200)
            .background(
                Image.Panel.Palette.sliderLine
                    .resizable()
                    .frame(height: 10)
            )
            .padding(.horizontal)
            .accentColor(.clear)
            .frame(width: 176, height: 56)
    }
    
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
