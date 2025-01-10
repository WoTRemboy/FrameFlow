//
//  CanvasHeaderView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/28/24.
//

import SwiftUI

/// The header view of the canvas editor, providing controls for undo/redo, layer management, and animation play/stop functions.
struct CanvasHeaderView: View {
    
    /// The view model that controls the state and actions of the canvas.
    @EnvironmentObject var viewModel: CanvasViewModel
    
    // MARK: - Body
    
    /// The main content of the header, which displays various tool buttons and play/stop controls.
    internal var body: some View {
        HStack {
            // Display undo, redo, and layer management buttons when animation is not active.
            if !viewModel.isAnimating {
                backForward
                Spacer()
            }
            playStop
            
            if !viewModel.isAnimating {
                Spacer()
                shareLayersSettings
            }
        }
    }
    
    // MARK: - Undo/Redo Controls
    
    /// Contains undo and redo buttons.
    private var backForward: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color.clear)
                .frame(width: 30, height: 40)
                .clipShape(.buttonBorder)
            
            HStack(spacing: 8) {
                // Undo button
                Button {
                    viewModel.undo()
                } label: {
                    viewModel.undoAvailableImage()
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24)
                }
                .disabled(!viewModel.undoAvailable())
                
                // Redo button
                Button {
                    viewModel.redo()
                } label: {
                    viewModel.redoAvailableImage()
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24)
                }
                .disabled(!viewModel.redoAvailable())
            }
        }
    }
    
    // MARK: - Layer Management Controls
    
    /// Contains buttons for managing layers: delete current layer, add a new layer, and open layer sheet.
    private var shareLayersSettings: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color.clear)
                .frame(width: 50, height: 40)
                .clipShape(.buttonBorder)
            
            HStack(spacing: 16) {
                // Button to share animation as a GIF
                Button {
                    viewModel.shareGIF()
                } label: {
                    (viewModel.isLayersEmpty() ? Image.TabBar.shareInactive : Image.TabBar.shareActive)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22)
                }
                .disabled(viewModel.isLayersEmpty())
                
                // Open storyboard sheet button
                Button {
                    viewModel.toggleLayerSheet()
                } label: {
                    Image.Header.Modifiers.layers
                        .resizable()
                        .scaledToFit()
                        .frame(height: 32)
                }
                
                // Change animation speed overlay button
                // Button to adjust animation speed
                NavigationLink(destination: SettingsView().environmentObject(SettingsViewModel(speed: viewModel.animationSpeed))) {
                    Image.Header.Modifiers.settings
                        .resizable()
                        .scaledToFit()
                        .frame(height: 24)
                }
            }
        }
    }
    
    // MARK: - Animation Controls
    
    /// Contains play and stop buttons for controlling animation playback, with additional options for adjusting speed and sharing as GIF.
    private var playStop: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color.clear)
                .frame(width: 140, height: 40)
                .clipShape(.buttonBorder)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.orangePalette, lineWidth: 2)
                )
                
            
            HStack(spacing: 16) {
                // Stop animation button
                Button {
                    viewModel.stopAnimation()
                } label: {
                    (viewModel.isAnimating ? Image.Header.Player.pauseActive : Image.Header.Player.pauseInactive)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24)
                }
                .disabled(!viewModel.isAnimating)
                
                // Start animation button with a context menu for speed and GIF options
                Button {
                    viewModel.startAnimation()
                } label: {
                    (viewModel.isAnimating || viewModel.isLayersEmpty() ? Image.Header.Player.playInactive : Image.Header.Player.playActive)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32)
                }
                .disabled(viewModel.isAnimating || viewModel.isLayersEmpty())
                
                Button {
                    viewModel.toggleGenerateParams()
                } label: {
                    (viewModel.isAnimating ? Image.Header.Player.generateInactive : Image.Header.Player.generateActive)
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                .disabled(viewModel.isAnimating)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    CanvasHeaderView()
        .environmentObject(CanvasViewModel())
}
