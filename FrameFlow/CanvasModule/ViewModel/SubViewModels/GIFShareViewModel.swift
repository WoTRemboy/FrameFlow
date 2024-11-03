//
//  GIFShareViewModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 11/3/24.
//

import SwiftUI
import UniformTypeIdentifiers

extension CanvasViewModel {
    @MainActor private func createGIF(from layers: [[Line]], frameDelay: Double, completion: @escaping (URL?) -> Void) {
        let fileProperties: [String: Any] = [
            kCGImagePropertyGIFDictionary as String: [
                kCGImagePropertyGIFLoopCount as String: 0
            ]
        ]
        
        let frameProperties: [String: Any] = [
            kCGImagePropertyGIFDictionary as String: [
                kCGImagePropertyGIFDelayTime as String: frameDelay
            ]
        ]
        
        let tempURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("animation.gif")
        
        guard let destination = CGImageDestinationCreateWithURL(tempURL as CFURL, UTType.gif.identifier as CFString, layers.count, nil) else {
            completion(nil)
            return
        }
        
        CGImageDestinationSetProperties(destination, fileProperties as CFDictionary)
        
        for layer in layers {
            let renderer = ImageRenderer(content: GIFShareView(lines: layer, width: canvasSize.width, height: canvasSize.height))
            renderer.scale = UIScreen.main.scale
            if let cgImage = renderer.cgImage {
                CGImageDestinationAddImage(destination, cgImage, frameProperties as CFDictionary)
            }
        }
        
        if CGImageDestinationFinalize(destination) {
            completion(tempURL)
        } else {
            completion(nil)
        }
    }
    
    @MainActor internal func shareGIF() {
        createGIF(from: layers, frameDelay: animationSpeed) { url in
            guard let url = url else { return }
            DispatchQueue.main.async {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let rootViewController = windowScene.windows.first?.rootViewController {
                    let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
                    rootViewController.present(activityVC, animated: true, completion: nil)
                }
            }
        }
    }
}
