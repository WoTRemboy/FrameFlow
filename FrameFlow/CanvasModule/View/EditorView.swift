//
//  EditorView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/28/24.
//

import SwiftUI

/// The main editor view where users interact with the canvas and toolbar options.
struct EditorView: View {
    
    /// The view model that controls the state and actions of the canvas.
    @EnvironmentObject private var viewModel: CanvasViewModel
    
    // MARK: - Body
    
    internal var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
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
                
                // Overlay for generate parameters
                if viewModel.isGenerateParamsVisible {
                    generateParams
                }
                
                // Overlay for creating gif message
                if viewModel.isCreatingGIFOverlayVisible {
                    creatingGIF
                }
                
                // Overlay for warning gif message
                if viewModel.isCreatingGIFWarningVisible {
                    warningGIF
                }
                
                // Color and shape pickers
                if viewModel.showColorPicker {
                    VStack(spacing: 8) {
                        if viewModel.showColorPalette {
                            ColorPaletteView()
                        }
                        ColorPickerShortView()
                        WidthSliderView()
                    }
                    .padding(.bottom, hasNotch() ? 110 : 65)
                    .zIndex(1)
                } else if viewModel.showShapePicker {
                    ShapesPickerView()
                        .padding(.bottom, hasNotch() ? 110 : 65)
                        .zIndex(1)
                }
            }
            .sheet(isPresented: $viewModel.isLayerSheetPresented) {
                LayerSheetView()
                    .environmentObject(viewModel)
            }
        }
    }
    
    // MARK: - Canvas View
    
    /// The main canvas area where drawing actions are rendered.
    private var canvas: some View {
        GeometryReader { geometry in
            CanvasView(lines: $viewModel.currentLayer, currentLine: $viewModel.currentLine, currentEraserLine: $viewModel.currentEraserLine, canvasSize: geometry.size)
                .background(canvasBackground)
                .gesture(DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        if viewModel.currentMode == .shape {
                            viewModel.tapLocation = value.startLocation
                            viewModel.updateShape(to: value.location, in: geometry.size)
                        } else {
                            viewModel.updateCurrentLine(with: value.location, in: geometry.size)
                        }
                    }
                    .onEnded { _ in
                        if viewModel.currentMode == .shape {
                            viewModel.finalizeShape()
                        } else {
                            viewModel.finalizeCurrentLine()
                        }
                    }
                         
                )
        }
        .padding(.vertical)
    }
    
    // MARK: - Generate Params Overlay
    
    /// An overlay to setup generations params with a tap-to-dismiss background.
    private var generateParams: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        viewModel.isGenerateParamsVisible = false
                    }
                }
            VStack {
                Spacer()
                GenerateParamsView()
                Spacer()
            }
        }
        .zIndex(1)
    }
    
    // MARK: - Creating GIF Overlay
    
    /// An overlay to show creating gif progress.
    private var creatingGIF: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                CreatingGIFOverlay()
                Spacer()
            }
        }
        .zIndex(1)
    }
    
    // MARK: - Warning GIF Overlay
    
    /// An overlay to show frame limit for generating gif.
    private var warningGIF: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        viewModel.isCreatingGIFWarningVisible = false
                    }
                }
            VStack {
                Spacer()
                GifWarningView()
                Spacer()
            }
        }
        .zIndex(1)
    }
    
    // MARK: - Background
    
    /// Background for the canvas.
    private var canvasBackground: some View {
        Image.Canvas.canvas
            .resizable()
            .clipShape(.rect(cornerRadius: 20))
    }
    
    /// Background color for the entire editor view.
    private var background: some View {
        Rectangle()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .foregroundStyle(Color.clear)
            .background(Color.BackColors.backPrimary)
    }
}

// MARK: - Preview

#Preview {
    EditorView()
        .environmentObject(CanvasViewModel())
}
