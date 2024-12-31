//
//  LinkRow.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 12/31/24.
//

import SwiftUI

struct LinkRow: View {
    
    private let title: String
    private let image: Image
    private let details: String?
    private let chevron: Bool
    
    init(title: String, image: Image,
         details: String? = nil, chevron: Bool = false) {
        self.title = title
        self.image = image
        self.details = details
        self.chevron = chevron
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
        }
    }
    
    private var leftLabel: some View {
        HStack(alignment: .center, spacing: 16) {
            image
                .resizable()
                .scaledToFit()
                .clipShape(.buttonBorder)
                .frame(width: 30)
            
            Text(title)
                .font(.regularBody())
                .foregroundStyle(Color.LabelColors.labelPrimary)
        }
    }
}


#Preview {
    LinkRow(title: "Title", image: Image.Settings.appearance, details: "hi", chevron: true)
}
