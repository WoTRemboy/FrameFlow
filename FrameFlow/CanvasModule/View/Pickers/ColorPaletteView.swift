//
//  ColorPaletteView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/30/24.
//

import SwiftUI

struct ColorPaletteView: View {
    
    @EnvironmentObject var viewModel: CanvasViewModel
    
    internal var body: some View {
        ZStack {
            background
            picker
        }
    }
    
    private var picker: some View {
        ColorPicker(Texts.ContextMenu.color, selection: $viewModel.selectedColor)
            .padding(.horizontal)
            .frame(width: 256, height: 56)
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
    ColorPaletteView()
        .environmentObject(CanvasViewModel())
}
