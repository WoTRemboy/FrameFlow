//
//  GifWarningView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 12/22/24.
//

import SwiftUI

/// A view overlay for warning user about frame limit.
struct GifWarningView: View {
    
    /// The view model that controls the state and actions of the canvas.
    @EnvironmentObject private var viewModel: CanvasViewModel

    // MARK: - Body
    
    /// The main content of the overlay, including the title, description, and "Ok" button.
    internal var body: some View {
        VStack(spacing: 10) {
            title
            description
            okButton
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
    
    /// Displays the title text for the overlay, providing context for the warning.
    private var title: some View {
        Text(Texts.CreatingGif.notCreatedGif)
            .font(.title())
            .padding(.top, 20)
    }
    
    // MARK: - Speed Display
    
    /// Shows details about limit..
    private var description: some View {
        Text(Texts.CreatingGif.notCreatedDescription)
            .font(.subhead())
            .padding(.bottom)
    }
    
    // MARK: - Done Button
    
    /// A button that toggles the visibility of the overlay.
    private var okButton: some View {
        Button {
            viewModel.toggleGIFWarning()
        } label: {
            Text(Texts.CreatingGif.ok)
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

// MARK: - Preview

#Preview {
    GifWarningView()
        .environmentObject(CanvasViewModel())
}
