//
//  CanvasHeaderView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/28/24.
//

import SwiftUI

struct CanvasHeaderView: View {
    
    @EnvironmentObject var viewModel: CanvasViewModel
    
    internal var body: some View {
        HStack {
            if !viewModel.isAnimating {
                backForward
                Spacer()
                binNewStory
            }
            Spacer()
            playStop
        }
    }
    
    private var backForward: some View {
        HStack(spacing: 8) {
            Button {
                viewModel.undo()
            } label: {
                viewModel.undoAvailableImage()
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24)
            }
            .disabled(!viewModel.undoAvailable())
            
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
    
    private var binNewStory: some View {
        HStack(spacing: 16) {
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
    
    private var deleteMenu: some View {
        Group {
            Button(Texts.ContextMenu.delete, action: {
                viewModel.deleteAllLayers()
            })
        }
    }
    
    private var copyMenu: some View {
        Group {
            Button(Texts.ContextMenu.copy, action: {
                viewModel.duplicateCurrentLayer()
            })
        }
    }
    
    private var playStop: some View {
        HStack(spacing: 16) {
            Button {
                viewModel.stopAnimation()
            } label: {
                (viewModel.isAnimating ? Image.Header.Player.pauseActive : Image.Header.Player.pauseInactive)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32)
            }
            .disabled(!viewModel.isAnimating)
            
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
    
    private var speedGifMenu: some View {
        Group {
            Button(Texts.ContextMenu.speed, action: {
                viewModel.toggleSpeedOverlay()
            })
            Button(Texts.ContextMenu.gif, action: {
                viewModel.shareGIF()
            })
        }
    }
}

#Preview {
    CanvasHeaderView()
        .environmentObject(CanvasViewModel())
}
