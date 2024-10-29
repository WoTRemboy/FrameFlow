//
//  ColorPickerShortView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/29/24.
//

import SwiftUI

struct ColorPickerShortView: View {
    
    internal var onColorSelected: (Color) -> Void
    
    internal var body: some View {
        ZStack {
            background
            buttons
        }
    }
    
    private var buttons: some View {
        HStack(spacing: 16) {
            Button {
                
            } label: {
                Image.Panel.Palette.paletteInactive
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32)
            }
            
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    onColorSelected(Color.PaletteColors.whitePalette)
                }
            } label: {
                Circle()
                    .scaledToFit()
                    .foregroundStyle(Color.PaletteColors.whitePalette)
                    .frame(width: 32)
            }
            
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    onColorSelected(Color.PaletteColors.redPalette)
                }
            } label: {
                Circle()
                    .scaledToFit()
                    .foregroundStyle(Color.PaletteColors.redPalette)
                    .frame(width: 32)
            }
            
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    onColorSelected(Color.PaletteColors.blackPalette)
                }
            } label: {
                Circle()
                    .scaledToFit()
                    .foregroundStyle(Color.PaletteColors.blackPalette)
                    .frame(width: 32)
            }
            
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    onColorSelected(Color.PaletteColors.bluePalette)
                }
            } label: {
                Circle()
                    .scaledToFit()
                    .foregroundStyle(Color.PaletteColors.bluePalette)
                    .frame(width: 32)
            }
        }
    }
    
    private var background: some View {
        RoundedRectangle(cornerRadius: 4)
            .foregroundStyle(Color.SupportColors.supportSelection)
            .opacity(0.1)
            .frame(width: 256, height: 64)
        
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.supportBorder, lineWidth: 1)
            )
        
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 4))
            .opacity(0.96)
    }
}

#Preview {
    ColorPickerShortView { _ in }
}
