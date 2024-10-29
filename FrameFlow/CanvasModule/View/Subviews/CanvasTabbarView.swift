//
//  CanvasTabbarView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/28/24.
//

import SwiftUI

struct CanvasTabbarView: View {
    @State private var colorSelected: Bool = false
    
    internal var onPaletteButtonTap: () -> Void
    
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
                    .foregroundStyle(Color.PaletteColors.bluePalette)
                    .scaledToFit()
                    .frame(width: 32)
                    .overlay(
                        Circle()
                            .stroke(colorSelected ? Color.PaletteColors.greenPalette : Color.clear, lineWidth: 1)
                    )
            }
        }
    }
}

#Preview {
    CanvasTabbarView(onPaletteButtonTap: {})
}
