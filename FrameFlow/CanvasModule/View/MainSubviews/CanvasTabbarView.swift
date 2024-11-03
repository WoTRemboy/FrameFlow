//
//  CanvasTabbarView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/28/24.
//

import SwiftUI

struct CanvasTabbarView: View {
    
    @EnvironmentObject private var viewModel: CanvasViewModel
    
    internal var body: some View {
        HStack(spacing: 16) {
            if !viewModel.isAnimating {
                pencilButton
                brushButton
                eraseButton
                shapeButton
                colorButton
            }
        }
        .frame(height: 32)
    }
    
    private var pencilButton: some View {
        Button {
            viewModel.selectMode(.pencil)
        } label: {
            viewModel.selectTabbarImage(
                targetMode: .pencil,
                currentMode: viewModel.currentMode,
                active: .TabBar.pencilSelected,
                inactive: .TabBar.pencilInactive)
                .resizable()
                .frame(width: 32, height: 32)
        }
    }
    
    private var brushButton: some View {
        Button {
            viewModel.selectMode(.brush)
        } label: {
            viewModel.selectTabbarImage(
                targetMode: .brush,
                currentMode: viewModel.currentMode,
                active: .TabBar.brushSelected,
                inactive: .TabBar.brushInactive)
                .resizable()
                .frame(width: 32, height: 32)
        }
    }
    
    private var eraseButton: some View {
        Button {
            viewModel.selectMode(.eraser)
        } label: {
            viewModel.selectTabbarImage(
                targetMode: .eraser,
                currentMode: viewModel.currentMode,
                active: .TabBar.eraseSelected,
                inactive: .TabBar.eraseInactive)
                .resizable()
                .frame(width: 32, height: 32)
        }
    }
    
    private var shapeButton: some View {
        Button {
            viewModel.toggleShapePicker()
        } label: {
            viewModel.selectTabbarImage(
                targetMode: .shape,
                currentMode: viewModel.currentMode,
                active: .TabBar.instrumentsSelected,
                inactive: .TabBar.instrumentsInactive)
                .resizable()
                .frame(width: 32, height: 32)
        }
        .onChange(of: viewModel.currentShape) {
            viewModel.toggleShapePicker()
        }
    }
    
    private var colorButton: some View {
        Button {
            viewModel.toggleColorPicker()
        } label: {
            Circle()
                .foregroundStyle(viewModel.selectedColor)
                .scaledToFit()
                .frame(width: 32)
                .overlay(
                    Circle()
                        .stroke(viewModel.currentMode == .palette ? Color.PaletteColors.greenPalette : Color.SupportColors.supportIconBorder, lineWidth: 1)
                )
        }
        .onChange(of: viewModel.selectedColor) {
            viewModel.selectMode(.pencil)
        }
    }
}

#Preview {
    @Previewable @State var previewMode: CanvasMode = .pencil
    
    CanvasTabbarView()
        .environmentObject(CanvasViewModel())
}
