//
//  SpeedSliderView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 11/3/24.
//

import SwiftUI

struct SpeedSliderOverlay: View {
    @EnvironmentObject private var viewModel: CanvasViewModel

    internal var body: some View {
        VStack(spacing: 16) {
            title
            units
            slider
            doneButton
        }
        .frame(width: 300)
        .background(Color.BackColors.backSecondary)
        .cornerRadius(12)
        .shadow(radius: 10)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
    
    private var title: some View {
        Text(Texts.AnimationOverlay.title)
            .font(.headline())
            .padding(.top)
    }
    
    private var units: some View {
        Text("\(String(format: "%.2f", viewModel.animationSpeed)) \(Texts.AnimationOverlay.units)")
            .font(.subhead())
    }
    
    private var slider: some View {
        Slider(value: $viewModel.animationSpeed, in: 0.01...1.0, step: 0.01)
            .background(
                Image.Panel.Palette.sliderLine
                    .resizable()
                    .frame(height: 10)
            )
            .accentColor(.clear)
            .padding(.horizontal)
    }
    
    private var doneButton: some View {
        Button {
            viewModel.toggleSpeedOverlay()
        } label: {
            Text(Texts.AnimationOverlay.done)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .frame(height: 40)
        .frame(maxWidth: .infinity)
        
        .tint(Color.PaletteColors.greenPalette)
        .foregroundColor(Color.PaletteColors.greenPalette)
        .buttonStyle(.bordered)
        .padding([.horizontal, .bottom])
    }
}

#Preview {
    SpeedSliderOverlay()
        .environmentObject(CanvasViewModel())
}
