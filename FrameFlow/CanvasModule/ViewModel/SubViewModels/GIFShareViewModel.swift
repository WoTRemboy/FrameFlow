//
//  GIFShareViewModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 11/3/24.
//

//
//  GIFShareViewModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 11/3/24.
//

import SwiftUI
import UniformTypeIdentifiers

extension CanvasViewModel {
    
    // MARK: - Create GIF from Layers Incrementally
    
    /// Creates a GIF from a series of canvas layers and saves it to a temporary file location.
    /// The process is optimized to reduce memory usage by incrementally processing frames.
    /// - Parameters:
    ///   - layers: The array of layers to convert into GIF frames.
    ///   - frameDelay: The delay time (in seconds) between frames in the GIF.
    ///   - completion: A closure called upon completion with the URL of the GIF file, or `nil` if creation failed.
    @MainActor private func createGIF(from layers: [[Line]], frameDelay: Double, completion: @escaping (URL?) -> Void) {
        
        // GIF properties: loop count set to 0 (infinite loop)
        let fileProperties: [String: Any] = [
            kCGImagePropertyGIFDictionary as String: [
                kCGImagePropertyGIFLoopCount as String: 0
            ]
        ]
        
        // Frame delay property for each frame in the GIF
        let frameProperties: [String: Any] = [
            kCGImagePropertyGIFDictionary as String: [
                kCGImagePropertyGIFDelayTime as String: frameDelay
            ]
        ]
        
        // Temporary URL for saving the GIF file
        let tempURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("FrameFlow.gif")
        
        guard let destination = CGImageDestinationCreateWithURL(tempURL as CFURL, UTType.gif.identifier as CFString, layers.count, nil) else {
            completion(nil)
            return
        }
        
        // Set GIF properties (e.g., looping behavior)
        CGImageDestinationSetProperties(destination, fileProperties as CFDictionary)
        let renderGroup = DispatchGroup()
        
        // Process each layer incrementally
        for layer in layers {
            DispatchQueue.main.async {
                autoreleasepool {
                    let renderer = ImageRenderer(content: GIFShareView(lines: layer, width: self.canvasSize.width, height: self.canvasSize.height))
                    renderer.scale = UIScreen.main.scale
                    if let cgImage = renderer.cgImage {
                        CGImageDestinationAddImage(destination, cgImage, frameProperties as CFDictionary)
                    }
                }
            }
        }
        
        // Finalize GIF creation after all frames are processed
        renderGroup.notify(queue: .main) {
            if CGImageDestinationFinalize(destination) {
                completion(tempURL)
            } else {
                completion(nil)
            }
        }
    }
    
    // MARK: - Share GIF
    
    /// Creates a GIF from the current layers and presents a share sheet for sharing the GIF file.
    @MainActor internal func shareGIF() {
        // Shows the creating gif overlay
        toggleCreatingGIF()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.createGIF(from: self.layers,
                           frameDelay: self.animationSpeed) { url in
                guard let url = url else { return }
                
                DispatchQueue.main.async {
                    // Hides the creating gif overlay
                    self.toggleCreatingGIF()
                    // Retrieve the root view controller to present the share sheet
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let rootViewController = windowScene.windows.first?.rootViewController {
                        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
                        rootViewController.present(activityVC, animated: true, completion: nil)
                    }
                }
            }
        }
    }
}
