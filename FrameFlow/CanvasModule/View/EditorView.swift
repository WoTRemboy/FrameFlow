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
                
                // Overlay for adjusting animation speed
                if viewModel.isSpeedOverlayVisible {
                    speedSlider
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
                    VStack(spacing: 8) {
                        ShapesPickerView()
                        ShapeHeightSliderView()
                    }
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
                            viewModel.addShape(at: value.location)
                            viewModel.finalizeShape()
                        } else {
                            viewModel.updateCurrentLine(with: value.location, in: geometry.size)
                        }
                    }
                    .onEnded { _ in
                        viewModel.finalizeCurrentLine()
                    }
                )
        }
        .padding(.vertical)
    }
    
    // MARK: - Speed Slider Overlay
    
    /// An overlay to adjust animation speed with a tap-to-dismiss background.
    private var speedSlider: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        viewModel.isSpeedOverlayVisible = false
                    }
                }
            VStack {
                Spacer()
                SpeedSliderOverlay()
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
            .background(Color.BackColors.backDefault)
    }
}

// MARK: - Preview

#Preview {
    EditorView()
        .environmentObject(CanvasViewModel())
}
