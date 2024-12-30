//
//  CanvasTabbarView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/28/24.
//

import SwiftUI

/// A tab bar at the bottom of the canvas, allowing the user to switch between tools for drawing, erasing, shaping, and coloring.
struct CanvasTabbarView: View {
    
    /// The view model that handles the canvas actions and state.
    @EnvironmentObject private var viewModel: CanvasViewModel
    
    // MARK: - Body
    
    /// The main content of the tab bar, displaying tool buttons when animation is not active.
    internal var body: some View {
        HStack {
            // Show tool buttons only when animation is inactive
            if !viewModel.isAnimating {
                layerControl
                Spacer()
                drawingInstruments
            }
        }
        .frame(height: 32)
    }
    
    private var layerControl: some View {
        HStack(spacing: 16) {
            addNewLayerButton
            deleteLayerButton
        }
    }
    
    private var drawingInstruments: some View {
        HStack(spacing: 16) {
            pencilButton
            brushButton
            eraseButton
            shapeButton
            colorButton
        }
    }
    
    // MARK: - Tool Buttons
    
    /// Button for the pencil tool.
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
    
    /// Button for the brush tool.
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
                .frame(width: 26, height: 26)
        }
    }
    
    /// Button for the eraser tool.
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
                .frame(width: 26, height: 26)
        }
    }
    
    /// Button for the shape tool, allowing the user to add shapes.
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
            // Automatically toggles the shape picker when the selected shape changes.
            viewModel.toggleShapePicker()
        }
    }
    
    /// Button for the color picker, allowing the user to select colors.
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
            // Sets the mode to pencil when a new color is selected.
            viewModel.selectMode(.pencil)
        }
    }
    
    private var addNewLayerButton: some View {
        // Add a new layer button with a context menu option to duplicate the current layer
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                viewModel.addLayer()
            }
        } label: {
            Image.Header.Modifiers.filePlus
                .resizable()
                .scaledToFit()
                .frame(height: 32)
        }
        .contextMenu {
            copyMenu
        }
    }
    
    private var deleteLayerButton: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                viewModel.deleteCurrentLayer()
            }
        } label: {
            (viewModel.isLayersEmpty() ? Image.Header.Modifiers.binInactive : Image.Header.Modifiers.bin)
                .resizable()
                .scaledToFit()
                .frame(height: 32)
        }
        .disabled(viewModel.isLayersEmpty())
        .contextMenu {
            if !viewModel.isLayersEmpty() {
                deleteMenu
            }
        }
    }
    
    /// Context menu option for deleting all layers.
    private var deleteMenu: some View {
        Group {
            Button {
                viewModel.deleteCurrentLayer()
            } label: {
                Label {
                    Text(Texts.ContextMenu.delete)
                } icon: {
                    Image.Header.Modifiers.delete
                }

            }
            
            Button {
                viewModel.deleteAllLayers()
            } label: {
                Label {
                    Text(Texts.ContextMenu.deleteAll)
                } icon: {
                    Image.Header.Modifiers.deleteAll
                }

            }
        }
    }
    
    /// Context menu option for creating, duplicating & generations layers.
    private var copyMenu: some View {
        Group {
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    viewModel.addLayer()
                }
            } label: {
                Label {
                    Text(Texts.ContextMenu.add)
                } icon: {
                    Image.Header.Modifiers.add
                }
            }
            
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    viewModel.duplicateCurrentLayer()
                }
            } label: {
                Label {
                    Text(Texts.ContextMenu.copy)
                } icon: {
                    Image.Header.Modifiers.copy
                }
            }
            
            Button {
                viewModel.toggleGenerateParams()
            } label: {
                Label {
                    Text(Texts.ContextMenu.generate)
                } icon: {
                    Image.Header.Modifiers.generate
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    @Previewable @State var previewMode: CanvasMode = .pencil
    
    CanvasTabbarView()
        .environmentObject(CanvasViewModel())
}
