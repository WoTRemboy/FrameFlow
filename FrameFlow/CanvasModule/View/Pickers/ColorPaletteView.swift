//
//  ColorPaletteView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/30/24.
//

import SwiftUI

/// A view that provides a color selection palette for customizing drawing colors on the canvas.
struct ColorPaletteView: View {
    
    /// The view model that controls the state and actions of the canvas.
    @EnvironmentObject var viewModel: CanvasViewModel
    
    /// The main content of the view, consisting of a color picker wrapped with a styled background.
    internal var body: some View {
        ZStack {
            background
            picker
        }
    }
    
    // MARK: - Picker
    
    /// The color picker allowing users to choose a color, which updates the view model's selected color.
    private var picker: some View {
        ColorPicker(Texts.ContextMenu.color, selection: $viewModel.selectedColor)
            .padding(.horizontal)
            .frame(width: 256, height: 56)
    }
    
    // MARK: - Background
    
    /// A styled background with rounded corners and a subtle border that complements the color picker.
    private var background: some View {
        RoundedRectangle(cornerRadius: 4)
            .foregroundStyle(Color.SupportColors.supportSelection)
            .opacity(0.1)
            .frame(width: 256, height: 64)
        
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
    ColorPaletteView()
        .environmentObject(CanvasViewModel())
}
