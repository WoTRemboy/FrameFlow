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
                binNewStory
            }
            Spacer()
            playStop
        }
    }
    
    // MARK: - Undo/Redo Controls
    
    /// Contains undo and redo buttons.
    private var backForward: some View {
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
    
    // MARK: - Layer Management Controls
    
    /// Contains buttons for managing layers: delete current layer, add a new layer, and open layer sheet.
    private var binNewStory: some View {
        HStack(spacing: 16) {
            // Delete current layer button with a context menu option to delete all layers
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    viewModel.deleteCurrentLayer()
                }
            } label: {
                (viewModel.isLayersEmpty() ? Image.Header.Modifiers.binInactive : Image.Header.Modifiers.bin)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32)
            }
            .disabled(viewModel.isLayersEmpty())
            .contextMenu {
                if !viewModel.isLayersEmpty() {
                    deleteMenu
                }
            }
            
            // Add a new layer button with a context menu option to duplicate the current layer
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    viewModel.addLayer()
                }
            } label: {
                Image.Header.Modifiers.filePlus
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32)
            }
            .contextMenu {
                copyMenu
            }
            
            // Open storyboard sheet button
            Button {
                viewModel.toggleLayerSheet()
            } label: {
                Image.Header.Modifiers.layers
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32)
            }
        }
    }
    
    /// Context menu option for deleting all layers.
    private var deleteMenu: some View {
        Group {
            Button(Texts.ContextMenu.delete, action: {
                viewModel.deleteAllLayers()
            })
        }
    }
    
    /// Context menu option for duplicating the current layer.
    private var copyMenu: some View {
        Group {
            Button(Texts.ContextMenu.copy, action: {
                viewModel.duplicateCurrentLayer()
            })
        }
    }
    
    // MARK: - Animation Controls
    
    /// Contains play and stop buttons for controlling animation playback, with additional options for adjusting speed and sharing as GIF.
    private var playStop: some View {
        HStack(spacing: 16) {
            // Stop animation button
            Button {
                viewModel.stopAnimation()
            } label: {
                (viewModel.isAnimating ? Image.Header.Player.pauseActive : Image.Header.Player.pauseInactive)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32)
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
            .contextMenu {
                if !viewModel.isAnimating && !viewModel.isLayersEmpty() {
                    speedGifMenu
                }
            }
        }
    }
    
    /// Context menu for adjusting animation speed and sharing as GIF.
    private var speedGifMenu: some View {
        Group {
            // Button to adjust animation speed
            Button(Texts.ContextMenu.speed, action: {
                viewModel.toggleSpeedOverlay()
            })
            
            // Button to share animation as a GIF
            Button(Texts.ContextMenu.gif, action: {
                viewModel.shareGIF()
            })
        }
    }
}

// MARK: - Preview

#Preview {
    CanvasHeaderView()
        .environmentObject(CanvasViewModel())
}
