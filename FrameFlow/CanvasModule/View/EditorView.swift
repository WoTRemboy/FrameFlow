//
//  EditorView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 10/28/24.
//

import SwiftUI

struct EditorView: View {
    @State private var lines: [Line] = []
    @State private var currentLine: Line = Line(points: [], color: .black, lineWidth: 5)
    
    @State private var selectedColor: Color = .black
    @State private var selectedShape: Shape = .square
    @State private var lineWidth: CGFloat = 5.0
    
    @State private var showColorPicker: Bool = false
    @State private var showShapePicker: Bool = false
    @State private var currentMode: CanvasMode = .pencil
    
    internal var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                background
                    .ignoresSafeArea()
                VStack {
                    CanvasHeaderView()
                    Spacer()
                    ZStack {
                        canvas
                    }
                    Spacer()
                    CanvasTabbarView(
                        currentMode: $currentMode,
                        selectedShape: selectedShape,
                        onShapeButtonTap: {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                showColorPicker = false
                                showShapePicker.toggle()
                            }
                        },
                        selectedColor: selectedColor, onPaletteButtonTap: {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                showShapePicker = false
                                showColorPicker.toggle()
                            }
                        })
                }
                .padding(.horizontal, 16)
                .padding(.vertical, hasNotch() ? 60 : 16)
                
                if showColorPicker {
                    ColorPickerShortView { color in
                        selectedColor = color
                    }
                        .padding(.bottom, hasNotch() ? 110 : 65)
                        .zIndex(1)
                } else if showShapePicker {
                    ShapesPickerView { shape in
                        selectedShape = shape
                    }
                        .padding(.bottom, hasNotch() ? 110 : 65)
                        .zIndex(1)
                }
            }
        }
    }
    
    private var canvas: some View {
        GeometryReader { geometry in
            CanvasView(lines: $lines, currentLine: $currentLine, canvasSize: geometry.size)
                .background(canvasBackground)
                .gesture(DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        let newPoint = value.location
                        
                        if newPoint.x >= lineWidth / 2, newPoint.x <= geometry.size.width - lineWidth / 2,
                           newPoint.y >= lineWidth / 2, newPoint.y <= geometry.size.height - lineWidth / 2 {
                            currentLine.points.append(newPoint)
                            currentLine.color = selectedColor
                            currentLine.lineWidth = lineWidth
                        }
                    }
                    .onEnded { _ in
                        lines.append(currentLine)
                        currentLine = Line(points: [], color: selectedColor, lineWidth: lineWidth)
                    }
                )
        }
        .padding(.vertical)
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
}
