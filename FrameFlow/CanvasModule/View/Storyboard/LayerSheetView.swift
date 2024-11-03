//
//  LayerSheetView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 11/2/24.
//

import SwiftUI

struct LayerSheetView: View {
    @EnvironmentObject var viewModel: CanvasViewModel
    
    internal var body: some View {
        NavigationView {
            VStack {
                List {
                    frameRows
                    addFrameRow
                }
            }
            .navigationBarTitle(Texts.LayerSheet.title, displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(Texts.LayerSheet.done) {
                        viewModel.isLayerSheetPresented.toggle()
                    }
                }
            }
        }
    }
    
    private var frameRows: some View {
        ForEach(viewModel.layers.indices, id: \.self) { index in
            HStack {
                viewModel.miniatureForLayer(at: index)
                    .resizable()
                    .frame(width: 50, height: 85)
                    .cornerRadius(10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                            .fill(Color.PaletteColors.whitePalette)
                    )
                    .padding([.trailing, .vertical])
                
                Text("\(Texts.LayerSheet.frame) \(index + 1)")
                    .font(.regularBody())
                    .foregroundColor(index == viewModel.currentLayerIndex ? Color.PaletteColors.bluePalette : Color.LabelColors.labelPrimary)
                Spacer()
                
                Button(action: {
                    viewModel.switchToLayer(at: index)
                    viewModel.isLayerSheetPresented.toggle()
                }) {
                    (index == viewModel.currentLayerIndex ? Image.LayerSheet.fill : Image.LayerSheet.circle)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(index == viewModel.currentLayerIndex ? .blue : .gray)
                        .frame(width: 20)
                }
            }
            
        }
        .onDelete(perform: !viewModel.isLayersEmpty() ? viewModel.deleteLayers : nil)
    }
    
    private var addFrameRow: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.2)) {
                viewModel.addLayer()
            }
        }) {
            Text(Texts.LayerSheet.add)
                .font(.regularBody())
                .foregroundColor(Color.LabelColors.labelDisable)
        }
    }
}

#Preview {
    LayerSheetView()
        .environmentObject(CanvasViewModel())
}
