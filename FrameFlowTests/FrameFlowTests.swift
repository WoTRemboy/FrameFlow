//
//  FrameFlowTests.swift
//  FrameFlowTests
//
//  Created by Roman Tverdokhleb on 11/4/24.
//

import XCTest
import SwiftUI
@testable import FrameFlow

/// Unit tests for `CanvasViewModel`, validating layer management, animation control, mode selection, color selection, and undo/redo functionality.
final class CanvasViewModelTests: XCTestCase {

    var viewModel: CanvasViewModel!

    override func setUp() {
        super.setUp()
        viewModel = CanvasViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    // MARK: - Layer Management Tests
    
    /// Tests the initial setup of layers, expecting one empty layer and a current index of 0.
    func testInitialLayerSetup() {
        XCTAssertEqual(viewModel.layers.count, 1)
        XCTAssertEqual(viewModel.currentLayerIndex, 0)
    }

    /// Tests adding a new layer, expecting the layer count to increase and the `currentLayerIndex` to update.
    func testAddLayer() {
        viewModel.addLayer()
        XCTAssertEqual(viewModel.layers.count, 2)
        XCTAssertEqual(viewModel.currentLayerIndex, 1)
    }

    /// Tests adding a layer to the end, expecting the new layer to be appended and the `currentLayerIndex` to move to the new layer.
    func testAddLayerToEnd() {
        viewModel.addLayerToEnd()
        XCTAssertEqual(viewModel.layers.count, 2)
        XCTAssertEqual(viewModel.currentLayerIndex, 1)
    }

    /// Tests deleting the current layer, expecting the layer count to decrease and `currentLayerIndex` to adjust.
    func testDeleteCurrentLayer() {
        viewModel.addLayer()
        viewModel.deleteCurrentLayer()
        XCTAssertEqual(viewModel.layers.count, 1)
        XCTAssertEqual(viewModel.currentLayerIndex, 0)
    }

    /// Tests deleting all layers, expecting only one empty layer to remain and `currentLayerIndex` to reset.
    func testDeleteAllLayers() {
        viewModel.addLayer()
        viewModel.deleteAllLayers()
        XCTAssertEqual(viewModel.layers.count, 1)
        XCTAssertEqual(viewModel.currentLayerIndex, 0)
    }

    // MARK: - Animation Tests

    /// Tests starting an animation, expecting `isAnimating` to be set to true.
    func testStartAnimation() {
        viewModel.addLayer()
        viewModel.startAnimation()
        XCTAssertTrue(viewModel.isAnimating)
    }

    /// Tests stopping an animation, expecting `isAnimating` to be set to false.
    func testStopAnimation() {
        viewModel.startAnimation()
        viewModel.stopAnimation()
        XCTAssertFalse(viewModel.isAnimating)
    }

    /// Tests toggling the animation speed overlay, expecting `isSpeedOverlayVisible` to toggle between true and false.
    func testToggleSpeedOverlay() {
        viewModel.toggleSpeedOverlay()
        XCTAssertTrue(viewModel.isSpeedOverlayVisible)
        
        viewModel.toggleSpeedOverlay()
        XCTAssertFalse(viewModel.isSpeedOverlayVisible)
    }

    // MARK: - Mode Selection Tests

    /// Tests selecting a drawing mode, expecting `currentMode` to update accordingly.
    func testSelectMode() {
        viewModel.selectMode(.brush)
        XCTAssertEqual(viewModel.currentMode, .brush)
        
        viewModel.selectMode(.eraser)
        XCTAssertEqual(viewModel.currentMode, .eraser)
    }

    // MARK: - Color and UI Tests

    /// Tests toggling the color picker, expecting `showColorPicker` to toggle and `currentMode` to switch to palette.
    func testToggleColorPicker() {
        viewModel.toggleColorPicker()
        XCTAssertTrue(viewModel.showColorPicker)
        XCTAssertEqual(viewModel.currentMode, .palette)
        
        viewModel.toggleColorPicker()
        XCTAssertFalse(viewModel.showColorPicker)
    }

    /// Tests toggling the color palette, expecting `showColorPalette` to toggle between true and false.
    func testToggleColorPalette() {
        viewModel.toggleColorPalette()
        XCTAssertTrue(viewModel.showColorPalette)
        
        viewModel.toggleColorPalette()
        XCTAssertFalse(viewModel.showColorPalette)
    }

    /// Tests selecting a color, expecting `selectedColor` to update to the new color.
    func testSelectColor() {
        let testColor = Color.red
        viewModel.selectColor(testColor)
        XCTAssertEqual(viewModel.selectedColor, testColor)
    }
    
    // MARK: - Undo/Redo Tests

    /// Tests undoing and redoing layer addition, expecting the layer count to revert to the previous state on undo and reapply on redo.
    func testUndoRedoLayerAddition() {
        viewModel.addLayer()
        XCTAssertEqual(viewModel.layers.count, 2)
        
        viewModel.undo()
        XCTAssertEqual(viewModel.layers.count, 1)
        
        viewModel.redo()
        XCTAssertEqual(viewModel.layers.count, 2)
    }

    /// Tests undoing and redoing layer deletion, expecting the layer count to revert and reapply as layers are removed and added back.
    func testUndoRedoLayerDeletion() {
        viewModel.addLayer()
        viewModel.deleteCurrentLayer()
        XCTAssertEqual(viewModel.layers.count, 1)
        
        viewModel.undo()
        XCTAssertEqual(viewModel.layers.count, 2)
        
        viewModel.redo()
        XCTAssertEqual(viewModel.layers.count, 1)
    }
}
