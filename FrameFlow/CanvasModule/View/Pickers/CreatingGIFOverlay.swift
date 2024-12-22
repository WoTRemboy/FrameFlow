//
//  CreatingGIFOverlay.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 12/22/24.
//

import SwiftUI

/// A view overlay for show creating gif process.
struct CreatingGIFOverlay: View {
    
    /// The view model that controls the state and actions of the canvas.
    @EnvironmentObject private var viewModel: CanvasViewModel

    // MARK: - Body
    
    /// The main content of the overlay.
    internal var body: some View {
        VStack {
            content
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
    
    // MARK: - Shape Picker
    
    /// Shows the label & progress view.
    private var content: some View {
        HStack {
            Text("\(Texts.ContextMenu.creatingGif)...")
                .font(.regularBody())
                .padding(.leading)
            Spacer()
            
            ProgressView()
                .padding([.leading, .trailing])
        }
        .padding([.top, .bottom])
    }
}

// MARK: - Preview

#Preview {
    CreatingGIFOverlay()
        .environmentObject(CanvasViewModel())
}
