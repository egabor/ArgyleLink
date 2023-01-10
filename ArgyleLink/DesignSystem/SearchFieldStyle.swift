//
//  SearchFieldStyle.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 10..
//

import SwiftUI

struct SearchFieldStyle: ViewModifier {

    let configuration: Configuration

    func body(content: Content) -> some View {
        content
            .background(Color.searchFieldBackground)
            .cornerRadius(configuration.cornerRadius)
            .accentColor(.searchFieldCaret)
            .font(configuration.font)
            .foregroundColor(.searchFieldText)
            .submitLabel(.search)
    }
}

extension SearchFieldStyle {

    struct Configuration {

        let font: Font
        let cornerRadius: Double

        init(
            font: Font = .system(size: 15, weight: .regular),
            cornerRadius: Double = 8.0
        ) {
            self.font = font
            self.cornerRadius = cornerRadius
        }
    }
}

extension View {

    func searchFieldStyle(
        configuration: SearchFieldStyle.Configuration = .init()
    ) -> some View {
        modifier(SearchFieldStyle(configuration: configuration))
    }
}
