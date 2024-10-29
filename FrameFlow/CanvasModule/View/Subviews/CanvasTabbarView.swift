//
//  CanvasTabbarView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/28/24.
//

import SwiftUI

struct CanvasTabbarView: View {
    
    private var selectedColor: Color
    @State private var colorSelected: Bool = false
    
    private var onPaletteButtonTap: () -> Void
    
    internal init(selectedColor: Color, onPaletteButtonTap: @escaping () -> Void) {
        self.selectedColor = selectedColor
        self.onPaletteButtonTap = onPaletteButtonTap
    }
    
    internal var body: some View {
        HStack(spacing: 16) {
            Button {
                
            } label: {
                Image.TabBar.pencilInactive
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32)
            }
            
            Button {
                
            } label: {
                Image.TabBar.brushInactive
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32)
            }
            
            Button {
                
            } label: {
                Image.TabBar.eraseInactive
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32)
            }
            
            Button {
                
            } label: {
                Image.TabBar.instrumentsInactive
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32)
            }
            
            Button {
                onPaletteButtonTap()
                withAnimation(.easeInOut(duration: 0.2)) {
                    colorSelected.toggle()
                }
            } label: {
                Circle()
                    .foregroundStyle(selectedColor)
                    .scaledToFit()
                    .frame(width: 32)
                    .overlay(
                        Circle()
                            .stroke(colorSelected ? Color.PaletteColors.greenPalette : Color.SupportColors.supportIconBorder, lineWidth: 1)
                    )
            }
            .onChange(of: selectedColor) { _, _ in
                onPaletteButtonTap()
                colorSelected.toggle()
            }
        }
    }
}

#Preview {
    CanvasTabbarView(selectedColor: .red, onPaletteButtonTap: {})
}
