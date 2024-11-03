//
//  EditorView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/28/24.
//

import SwiftUI

struct EditorView: View {
    @EnvironmentObject private var viewModel: CanvasViewModel
    
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
                
                if viewModel.isSpeedOverlayVisible {
                    speedSlider
                }
                
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
    
    private var canvasBackground: some View {
        Image.Canvas.canvas
            .resizable()
            .clipShape(.rect(cornerRadius: 20))
    }
    
    private var background: some View {
        Rectangle()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .foregroundStyle(Color.clear)
            .background(Color.BackColors.backDefault)
    }
}

#Preview {
    EditorView()
        .environmentObject(CanvasViewModel())
}
