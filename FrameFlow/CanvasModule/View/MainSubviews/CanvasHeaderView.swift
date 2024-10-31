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
            backForward
            Spacer()
            binNewCopy
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
    
    private var binNewCopy: some View {
        HStack(spacing: 16) {
            Button {
                
            } label: {
                Image.Header.Modifiers.bin
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32)
            }
            
            Button {
                
            } label: {
                Image.Header.Modifiers.filePlus
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32)
            }
            
            Button {
                
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
                
            } label: {
                Image.Header.Player.pauseInactive
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32)
            }
            
            Button {
                
            } label: {
                Image.Header.Player.playActive
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32)
            }
        }
    }
}

#Preview {
    CanvasHeaderView()
        .environmentObject(CanvasViewModel())
}
