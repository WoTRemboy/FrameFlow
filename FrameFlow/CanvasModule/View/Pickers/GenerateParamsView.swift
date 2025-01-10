//
//  GenerateParamsView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 12/21/24.
//

import SwiftUI

/// A view overlay for setup generation params, featuring a slider and a completion button.
struct GenerateParamsView: View {
    
    /// The view model that controls the state and actions of the canvas.
    @EnvironmentObject private var viewModel: CanvasViewModel

    // MARK: - Body
    
    /// The main content of the overlay
    internal var body: some View {
        VStack {
            title
            framesLabel
            slider
            separator
            shapePicker
            
            HStack(spacing: 16) {
                cancelButton
                doneButton
            }
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
    
    /// Displays the title text for the overlay, providing context for the generation params.
    private var title: some View {
        Text(Texts.GenerateParams.title)
            .font(.title())
            .padding(.top, 20)
    }
    
    // MARK: - Shape Picker
    
    /// Shows the current selected shape.
    private var shapePicker: some View {
        HStack {
            Text("\(Texts.GenerateParams.shapeSelected):")
                .font(.regularBody())
                .padding(.leading)
            Spacer()
            
            Picker(Texts.GenerateParams.shape, selection: $viewModel.generateShapeSelected.animation()) {
                Text(Texts.GenerateParams.triangle).tag(ShapeMode.triangle)
                Text(Texts.GenerateParams.square).tag(ShapeMode.square)
                Text(Texts.GenerateParams.circle).tag(ShapeMode.circle)
                Text(Texts.GenerateParams.arrow).tag(ShapeMode.arrow)
            }
            .pickerStyle(.menu)
            .padding(.trailing, 2)
            .tint(Color.LabelColors.labelDetails)
        }
        .padding(.bottom, 10)
    }
    
    // MARK: - Frames count Text
    
    private var framesLabel: some View {
        Text("\(Texts.GenerateParams.framesCount): \(String(format: "%.0f", viewModel.generateFramesCount))")
            .font(.subhead())
            .padding(.top, 2)
    }
    
    // MARK: - Speed Slider
    
    /// A slider for setting frames count, with a custom track image and step increments.
    private var slider: some View {
        Slider(value: $viewModel.generateFramesCount, in: 1...1000, step: 1)
            .background(
                Image.Panel.Palette.sliderLine
                    .resizable()
                    .frame(height: 10)
            )
            .accentColor(.clear)
            .padding(.horizontal)
            .padding(.bottom, 8)
    }
    
    // MARK: - Done Button
    
    /// A button that toggles the visibility of the overlay.
    private var doneButton: some View {
        Button {
            viewModel.generateAnimationSequence()
            viewModel.toggleGenerateParams()
        } label: {
            Text(Texts.GenerateParams.done)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .frame(height: 40)
        .frame(maxWidth: .infinity)
        
        .tint(Color.PaletteColors.orangePalette)
        .foregroundColor(Color.PaletteColors.orangePalette)
        .buttonStyle(.bordered)
        .padding([.trailing, .bottom])
    }
    
    private var cancelButton: some View {
        Button {
            viewModel.toggleGenerateParams()
        } label: {
            Text(Texts.GenerateParams.cancel)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .frame(height: 40)
        .frame(maxWidth: .infinity)
        
        .tint(Color.PaletteColors.redPalette)
        .foregroundColor(Color.PaletteColors.redPalette)
        .buttonStyle(.bordered)
        .padding([.leading, .bottom])
    }
    
    private var separator: some View {
        Rectangle()
            .padding(.horizontal)
            .frame(height: 1)
            .foregroundStyle(Color.LabelColors.labelDisable)
            .padding(.bottom, 8)
    }
}

// MARK: - Preview

#Preview {
    GenerateParamsView()
        .environmentObject(CanvasViewModel())
}
