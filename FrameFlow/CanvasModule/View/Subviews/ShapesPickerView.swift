//
//  ShapesPickerView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/30/24.
//

import SwiftUI

struct ShapesPickerView: View {
    
    internal var onShapeSelected: (Shape) -> Void
    
    internal var body: some View {
        ZStack {
            background
            buttons
        }
    }
    
    private var buttons: some View {
        HStack(spacing: 16) {
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    onShapeSelected(.square)
                }
            } label: {
                Image.Panel.Shapes.square
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    onShapeSelected(.circle)
                }
            } label: {
                Image.Panel.Shapes.cicle
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    onShapeSelected(.triangle)
                }
            } label: {
                Image.Panel.Shapes.triangle
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    onShapeSelected(.arrow)
                }
            } label: {
                Image.Panel.Shapes.arrowUp
                    .resizable()
                    .frame(width: 24, height: 24)
            }
        }
    }
    
    private var background: some View {
        RoundedRectangle(cornerRadius: 4)
            .foregroundStyle(Color.SupportColors.supportSelection)
            .opacity(0.1)
            .frame(width: 176, height: 56)
        
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.supportBorder, lineWidth: 1)
            )
        
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 4))
            .opacity(0.96)
    }
}

#Preview {
    ShapesPickerView { _ in }
}
