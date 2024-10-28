//
//  CanvasView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/28/24.
//

import SwiftUI

struct CanvasView: View {
    
    internal var body: some View {
        NavigationStack {
            ZStack {
                background
                    .ignoresSafeArea()
                VStack {
                    CanvasHeaderView()
                    Spacer()
                    canvas
                    Spacer()
                    CanvasTabbarView()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, hasNotch() ? 60 : 16)
            }
        }
    }
    
    private var canvas: some View {
        Image.Canvas.canvas
            .resizable()
            .padding(.top, 32)
            .padding(.bottom, 22)
    }
    
    private var background: some View {
        Rectangle()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .foregroundStyle(Color.clear)
            .background(Color.BackColors.backDefault)
    }
}

#Preview {
    CanvasView()
}
