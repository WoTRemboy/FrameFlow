//
//  CanvasTabbarView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/28/24.
//

import SwiftUI

struct CanvasTabbarView: View {
    
    @Binding var currentMode: CanvasMode
    
    internal var selectedColor: Color
    internal var onPaletteButtonTap: () -> Void
    
    internal var body: some View {
        HStack(spacing: 16) {
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    currentMode = .pencil
                }
            } label: {
                (currentMode == .pencil ? Image.TabBar.pencilSelected : Image.TabBar.pencilInactive)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32)
            }
            
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    currentMode = .brush
                }
            } label: {
                (currentMode == .brush ? Image.TabBar.brushSelected : Image.TabBar.brushInactive)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32)
            }
            
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    currentMode = .eraser
                }
            } label: {
                (currentMode == .eraser ? Image.TabBar.eraseSelected : Image.TabBar.eraseInactive)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32)
            }
            
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    currentMode = .instruments
                }
            } label: {
                (currentMode == .instruments ? Image.TabBar.instrumentsSelected : Image.TabBar.instrumentsInactive)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32)
            }
            
            Button {
                onPaletteButtonTap()
                withAnimation(.easeInOut(duration: 0.2)) {
                    currentMode = .palette
                }
            } label: {
                Circle()
                    .foregroundStyle(selectedColor)
                    .scaledToFit()
                    .frame(width: 32)
                    .overlay(
                        Circle()
                            .stroke(currentMode == .palette ? Color.PaletteColors.greenPalette : Color.SupportColors.supportIconBorder, lineWidth: 1)
                    )
            }
            .onChange(of: selectedColor) { _, _ in
                onPaletteButtonTap()
            }
        }
    }
}

#Preview {
    @Previewable @State var previewMode: CanvasMode = .pencil
    
    CanvasTabbarView(currentMode: $previewMode, selectedColor: .red, onPaletteButtonTap: {})
}
