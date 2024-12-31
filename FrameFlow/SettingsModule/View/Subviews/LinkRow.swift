//
//  LinkRow.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 12/31/24.
//

import SwiftUI

struct LinkRow: View {
    
    private let title: String
    private let image: Image?
    private let details: String?
    private let chevron: Bool
    private let check: Bool
    
    init(title: String, image: Image? = nil,
         details: String? = nil, chevron: Bool = false, check: Bool = false) {
        self.title = title
        self.image = image
        self.details = details
        self.chevron = chevron
        self.check = check
    }
    
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


#Preview {
    LinkRow(title: "Title", image: Image.Settings.appearance, details: "hi", chevron: true, check: true)
}
