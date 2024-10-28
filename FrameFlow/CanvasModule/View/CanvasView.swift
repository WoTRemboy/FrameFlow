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
                VStack {
                    CanvasHeaderView()
                    Spacer()
                    canvas
                    Spacer()
                    CanvasTabbarView()
                }
                .padding(.vertical, 32)
                .safeAreaPadding()
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
