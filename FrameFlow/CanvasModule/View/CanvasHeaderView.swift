//
//  CanvasHeaderView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/28/24.
//

import SwiftUI

struct CanvasHeaderView: View {
    
    internal var body: some View {
        HStack {
            backForward
            Spacer()
            binNewCopy
            Spacer()
            playStop
        }
    }
    
    private var backForward: some View {
        HStack(spacing: 8) {
            Button {
                
            } label: {
                Image.Header.Arrows.rightActive
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24)
            }
            
            Button {
                
            } label: {
                Image.Header.Arrows.leftInactive
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24)
            }
        }
    }
    
    private var binNewCopy: some View {
        HStack(spacing: 16) {
            Button {
                
            } label: {
                Image.Header.Modifiers.bin
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32)
            }
            
            Button {
                
            } label: {
                Image.Header.Modifiers.filePlus
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32)
            }
            
            Button {
                
            } label: {
                Image.Header.Modifiers.layers
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32)
            }
        }
    }
    
    private var playStop: some View {
        HStack(spacing: 16) {
            Button {
                
            } label: {
                Image.Header.Player.pauseInactive
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32)
            }
            
            Button {
                
            } label: {
                Image.Header.Player.playActive
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32)
            }
        }
    }
}

#Preview {
    CanvasHeaderView()
}
