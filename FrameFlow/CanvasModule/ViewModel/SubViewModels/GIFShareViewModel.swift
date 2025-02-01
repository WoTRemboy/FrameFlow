//
//  GIFShareViewModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 11/3/24.
//

import SwiftUI
import UniformTypeIdentifiers


extension CanvasViewModel {
    /// A reference to the GIF creation task, allowing it to be cancelled at any time.
    private var gifTask: Task<Void, Never>? {
        get { _gifTask }
        set { _gifTask = newValue }
    }
    
    /// Asynchronously creates a GIF from an array of layers.
    ///
    /// - Parameters:
    ///   - layers: An array of layers (each layer is an array of lines) to convert into GIF frames.
    ///   - frameDelay: The delay between frames in the GIF.
    /// - Returns: A URL pointing to the temporary file containing the created GIF.
    /// - Throws: An error if the destination cannot be created or if finalizing the GIF fails.
    @MainActor
    private func createGIF(from layers: [[Line]], frameDelay: Double) async throws -> URL {
        // GIF properties
        let fileProperties: [String: Any] = [
            kCGImagePropertyGIFDictionary as String: [
                kCGImagePropertyGIFLoopCount as String: 0
            ]
        ]
        // Frame properties (delay between frames)
        let frameProperties: [String: Any] = [
            kCGImagePropertyGIFDictionary as String: [
                kCGImagePropertyGIFDelayTime as String: frameDelay
            ]
        ]
        
        // Temporary URL for saving the GIF file
        let tempURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("FrameFlow.gif")
        
        // Create a destination for writing the GIF
        guard let destination = CGImageDestinationCreateWithURL(
            tempURL as CFURL,
            UTType.gif.identifier as CFString,
            layers.count,
            nil) else {
            throw GIFCreationError.destinationCreationFailed
        }
        CGImageDestinationSetProperties(destination, fileProperties as CFDictionary)
        
        // Process each layer (frame) sequentially
        for layer in layers {
            // Check if the task has been cancelled
            try Task.checkCancellation()
            
            // Use autoreleasepool to reduce memory usage
            autoreleasepool {
                // Render the frame content using SwiftUI's ImageRenderer
                let renderer = ImageRenderer(content: GIFShareView(lines: layer,
                                                                   width: self.canvasSize.width,
                                                                   height: self.canvasSize.height))
                renderer.scale = UIScreen.main.scale
                if let cgImage = renderer.cgImage {
                    CGImageDestinationAddImage(destination,
                                               cgImage,
                                               frameProperties as CFDictionary)
                }
            }
            // Yield to allow other tasks to run and check for cancellation
            await Task.yield()
        }
        
        // Finalize the GIF creation process
        if CGImageDestinationFinalize(destination) {
            return tempURL
        } else {
            throw GIFCreationError.finalizationFailed
        }
    }
    
    /// Initiates GIF creation and presents the standard share sheet upon completion.
    ///
    /// If the number of layers exceeds a preset limit, a warning overlay is displayed.
    @MainActor
    func shareGIF() {
        // Limit the number of layers to prevent performance issues
        guard layers.count < 102 else {
            toggleGIFWarning()
            return
        }
        
        // Show the overlay indicating that the GIF is being created
        toggleCreatingGIF()
        
        // Cancel any previously running GIF creation task
        gifTask?.cancel()
        
        gifTask = Task {
            do {
                // Attempt to create the GIF
                let gifURL = try await createGIF(from: layers, frameDelay: animationSpeed)
                // Check for cancellation
                try Task.checkCancellation()
                
                // Hide the GIF creation overlay
                toggleCreatingGIF()
                
                // Present the share sheet to share the created GIF
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let rootViewController = windowScene.windows.first?.rootViewController {
                    let activityVC = UIActivityViewController(activityItems: [gifURL], applicationActivities: nil)
                    rootViewController.present(activityVC, animated: true)
                }
            } catch {
                if (error as? CancellationError) != nil {
                    print("GIF creation was cancelled.")
                } else {
                    print("Error during GIF creation: \(error)")
                }
                
                // Hide the overlay regardless of the error
                toggleCreatingGIF()
            }
        }
    }
    
    /// Cancels the ongoing GIF creation process.
    ///
    /// This method cancels the current GIF creation task and hides the creation overlay.
    @MainActor
    internal func cancelGIFCreation() {
        gifTask?.cancel()
        gifTask = nil
        toggleCreatingGIF()
    }
    
    /// Errors that may occur during GIF creation.
    enum GIFCreationError: Error {
        case destinationCreationFailed
        case finalizationFailed
    }
}
