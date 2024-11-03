//
//  GIFShareViewModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 11/3/24.
//

import SwiftUI
import ImageIO
import UniformTypeIdentifiers
import MobileCoreServices

extension CanvasViewModel {
    func generateGIF(completion: @escaping (URL?) -> Void) {
        let tempDirectory = FileManager.default.temporaryDirectory
        let gifURL = tempDirectory.appendingPathComponent("animation.gif")

        guard let destination = CGImageDestinationCreateWithURL(gifURL as CFURL, UTType.gif.identifier as CFString, layers.count, nil) else {
            completion(nil)
            return
        }

        let frameDuration = animationSpeed
        let gifProperties = [
            kCGImagePropertyGIFDictionary: [
                kCGImagePropertyGIFLoopCount: 0
            ]
        ] as CFDictionary
        CGImageDestinationSetProperties(destination, gifProperties)

        for layer in layers {
            if let image = imageFromLayer(layer) {
                let frameProperties = [
                    kCGImagePropertyGIFDictionary: [
                        kCGImagePropertyGIFDelayTime: frameDuration
                    ]
                ] as CFDictionary

                if let cgImage = image.cgImage {
                    CGImageDestinationAddImage(destination, cgImage, frameProperties)
                }
            }
        }

        if CGImageDestinationFinalize(destination) {
            completion(gifURL)
        } else {
            completion(nil)
        }
    }

    private func imageFromLayer(_ layer: [Line]) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 340, height: 570))
        return renderer.image { context in
            for line in layer {
                context.cgContext.setStrokeColor(line.color.cgColor!)
                context.cgContext.setLineWidth(line.lineWidth)
                context.cgContext.setLineCap(.round)
                
                guard let firstPoint = line.points.first else { continue }
                context.cgContext.move(to: firstPoint)
                for point in line.points.dropFirst() {
                    context.cgContext.addLine(to: point)
                }
                context.cgContext.strokePath()
            }
        }
    }
}
