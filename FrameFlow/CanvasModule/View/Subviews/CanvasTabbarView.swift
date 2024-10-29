//
//  CanvasTabbarView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/28/24.
//

import SwiftUI

struct CanvasTabbarView: View {
    
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
                
            } label: {
                Circle()
                    .foregroundStyle(Color.PaletteColors.bluePalette)
                    .scaledToFit()
                    .frame(width: 32)
            }
        }
    }
}

#Preview {
    CanvasTabbarView()
}
