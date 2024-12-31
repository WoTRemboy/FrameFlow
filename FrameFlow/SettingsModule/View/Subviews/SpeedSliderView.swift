//
//  SpeedSliderView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 11/3/24.
//

import SwiftUI

/// A view overlay for adjusting the animation speed, featuring a slider and a completion button.
struct SpeedSliderOverlay: View {
    
    /// The view model that controls the state and actions of the canvas.
    @EnvironmentObject private var viewModel: SettingsViewModel

    // MARK: - Body
    
    /// The main content of the overlay, including the title, speed display, slider, and "Done" button.
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
    
    // MARK: - Title
    
    /// Displays the title text for the overlay, providing context for the speed adjustment.
    private var title: some View {
        Text(Texts.AnimationOverlay.title)
            .font(.title())
            .padding(.top, 20)
    }
    
    // MARK: - Speed Display
    
    /// Shows the current animation speed in a formatted string, updating with slider changes.
    private var units: some View {
        Text("\(String(format: "%.2f", viewModel.speed)) \(Texts.AnimationOverlay.units)")
            .font(.subhead())
    }
    
    // MARK: - Speed Slider
    
    /// A slider for setting animation speed, with a custom track image and step increments.
    private var slider: some View {
        Slider(value: $viewModel.speed, in: 0.01...1.0, step: 0.01)
            .background(
                Image.Panel.Palette.sliderLine
                    .resizable()
                    .frame(height: 10)
            )
            .accentColor(.clear)
            .padding(.horizontal)
    }
    
    // MARK: - Done Button
    
    /// A button that toggles the visibility of the overlay.
    private var doneButton: some View {
        Button {
            viewModel.setSpeed(to: viewModel.speed)
            viewModel.showSpeedOverlayToggle()
        } label: {
            Text(Texts.AnimationOverlay.done)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .frame(height: 40)
        .frame(maxWidth: .infinity)
        
        .tint(Color.PaletteColors.orangePalette)
        .foregroundColor(Color.PaletteColors.orangePalette)
        .buttonStyle(.bordered)
        .padding([.horizontal, .bottom])
    }
}

// MARK: - Preview

#Preview {
    SpeedSliderOverlay()
        .environmentObject(SettingsViewModel(speed: 0.1))
}
