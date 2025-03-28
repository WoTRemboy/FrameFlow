//
//  SplashScreenView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/29/24.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var isActive = false
    
    internal var body: some View {
        if isActive {
            OnboardingScreenView()
                .environmentObject(OnboardingViewModel())
        } else {
            content
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
        }
    }
        
    private var content: some View {
        ZStack {
            Color.BackColors.backDefault
                .ignoresSafeArea()
            
            Image.Opening.SplashScreen.splashLogo
                .resizable()
                .scaledToFit()
                .frame(width: 350)
        }
    }
}

#Preview {
    SplashScreenView()
}
