//
//  LinkRow.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 12/31/24.
//

import SwiftUI

/// A reusable row component for displaying settings or navigation options in a list.
///
/// This component supports an optional icon, detail text, a trailing chevron, and a checkmark.
struct LinkRow: View {
    
    // MARK: - Properties
    
    /// The main title to be displayed in the row.
    private let title: String
    
    /// An optional image shown to the left of the title.
    private let image: Image?
    
    /// Optional detail text shown on the right side.
    private let details: String?
    
    /// Indicates whether a chevron icon should appear on the trailing edge of the row.
    private let chevron: Bool
    
    /// Indicates whether a checkmark should appear on the trailing edge of the row.
    private let check: Bool
    
    // MARK: - Initialization
    
    /// Initializes a `LinkRow` with specified content and style.
    /// - Parameters:
    ///   - title: The main text displayed in the row.
    ///   - image: An optional `Image` shown to the left of the title.
    ///   - details: An optional string displayed on the trailing side of the row.
    ///   - chevron: A Boolean indicating whether a chevron icon (`>`) should be shown.
    ///   - check: A Boolean indicating whether a checkmark should be shown.
    init(title: String, image: Image? = nil,
         details: String? = nil, chevron: Bool = false, check: Bool = false) {
        self.title = title
        self.image = image
        self.details = details
        self.chevron = chevron
        self.check = check
    }
    
    // MARK: - Body
    
    /// The main content of the row, composed of a title, optional detail text, and optional icons.
    internal var body: some View {
        HStack {
            leftLabel
            
            Spacer()
            if let details {
                Text(details)
                    .font(.regularBody())
                    .lineLimit(1)
                    .foregroundStyle(Color.LabelColors.labelSecondary)
            }
            
            if chevron {
                Image(systemName: "chevron.right")
                    .font(.footnote())
                    .fontWeight(.bold)
                    .foregroundStyle(Color.LabelColors.labelDetails)
            }
            
            if check {
                Image(systemName: "checkmark")
                    .font(.regularBody())
                    .foregroundStyle(Color.accentColor)
            }
        }
    }
    
    // MARK: - Subview
    
    /// A subview that displays an optional icon followed by the title text.
    private var leftLabel: some View {
        HStack(alignment: .center, spacing: 16) {
            if let image {
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(.buttonBorder)
                    .frame(width: 30)
            }
            
            Text(title)
                .font(.regularBody())
                .foregroundStyle(Color.LabelColors.labelPrimary)
        }
    }
}

// MARK: - Preview

#Preview {
    LinkRow(title: "Title", image: Image.Settings.appearance, details: "hi", chevron: true, check: true)
}
