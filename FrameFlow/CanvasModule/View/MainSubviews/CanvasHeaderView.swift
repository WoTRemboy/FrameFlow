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
                menuItems
            }
        }
    }
    
    private var menuItems: some View {
        Group {
            Button(Texts.ContextMenu.speed, action: {
                viewModel.toggleSpeedOverlay()
            })
            Button(Texts.ContextMenu.gif, action: {})
        }
    }
}

#Preview {
    CanvasHeaderView()
        .environmentObject(CanvasViewModel())
}
