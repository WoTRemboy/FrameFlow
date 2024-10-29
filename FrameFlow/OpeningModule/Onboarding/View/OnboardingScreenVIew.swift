//
//  OnboardingScreenVIew.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/30/24.
//

import SwiftUI

struct OnboardingScreenView: View {
    
    @EnvironmentObject private var viewModel: OnboardingViewModel
    
    internal var body: some View {
        if viewModel.firstLaunch {
            EditorView()
        } else {
            VStack {
                skipButton
                content
                progressCircles
                actionButton
            }
        }
    }
    
    private var skipButton: some View {
        HStack {
            Spacer()
            Text(Texts.OnboardingPage.skip)
                .font(.body)
                .foregroundStyle(viewModel.buttonType == .nextPage ? Color.labelSecondary : Color.clear)
                .padding(.horizontal)
                .padding(.top)
            
                .onTapGesture {
                    viewModel.skipSteps()
                }
        }
        .disabled(viewModel.buttonType == .getStarted)
        .animation(.easeInOut, value: viewModel.buttonType)
    }
    
    private var content: some View {
        TabView(selection: $viewModel.currentStep) {
            ForEach(0 ..< viewModel.stepsCount, id: \.self) { index in
                VStack(spacing: 16) {
                    viewModel.steps[index].image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .clipShape(.buttonBorder)
                    
                    Text(viewModel.steps[index].name)
                        .font(.largeTitle())
                        .padding(.top)
                    
                    Text(viewModel.steps[index].description)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
                .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
    
    private var progressCircles: some View {
        HStack {
            ForEach(0 ..< viewModel.stepsCount, id: \.self) { step in
                if step == viewModel.currentStep {
                    Circle()
                        .frame(width: 15, height: 15)
                        .foregroundStyle(Color.Tints.blue)
                        .transition(.scale)
                        .animation(.easeInOut(duration: 0.3), value: viewModel.currentStep)
                } else {
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(Color.labelDisable)
                        .transition(.scale)
                        .animation(.easeInOut(duration: 0.3), value: viewModel.currentStep)
                }
            }
        }
        .animation(.easeInOut, value: viewModel.currentStep)
    }
    
    private var actionButton: some View {
        Button {
            switch viewModel.buttonType {
            case .nextPage:
                viewModel.nextStep()
            case .getStarted:
                viewModel.getStarted()
            }
        } label: {
            switch viewModel.buttonType {
            case .nextPage:
                Text(Texts.OnboardingPage.next)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            case .getStarted:
                Text(Texts.OnboardingPage.started)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        }
        .frame(height: 50)
        .frame(maxWidth: .infinity)
        .minimumScaleFactor(0.4)
        
        .foregroundStyle(viewModel.buttonType == .nextPage ? Color.orange : Color.green)
        .tint(viewModel.buttonType == .nextPage ? Color.orange : Color.green)
        .buttonStyle(.bordered)
        
        .padding(.horizontal)
        .padding(.vertical, 30)
        
        .animation(.easeInOut, value: viewModel.buttonType)
    }
}

#Preview {
    OnboardingScreenView()
}
