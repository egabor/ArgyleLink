//
//  Loading.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 10..
//

import SwiftUI

struct Loading: ViewModifier {

    private let fadeTransition: AnyTransition = .opacity.animation(.easeInOut)

    private var isLoading: Bool
    let configuration: Configuration

    init(_ isLoading: Bool, configuration: Configuration) {
        self.isLoading = isLoading
        self.configuration = configuration
    }

    func body(content: Content) -> some View {
        content
            .overlay(loadingView)
    }

    @ViewBuilder
    var loadingView: some View {
        if isLoading {
            ZStack {
                configuration.backgroundColor
                    .opacity(configuration.backgroundOpacity)
                    .edgesIgnoringSafeArea(.all)
                loadingIndicator
            }
            .transition(fadeTransition)
        }
    }

    var loadingIndicator: some View {
        ProgressView()
            .progressViewStyle(
                CircularProgressViewStyle(tint: configuration.progressViewColor)
            )
            .scaleEffect(configuration.progressViewScaleSize, anchor: .center)
    }
}

extension Loading {

    struct Configuration {

        let backgroundOpacity: Double
        let backgroundColor: Color
        let progressViewScaleSize: Double
        let progressViewColor: Color

        init(
            backgroundOpacity: Double = 0.4,
            backgroundColor: Color = .black,
            progressViewScaleSize: Double = 1.7,
            progressViewColor: Color = .white
        ) {
            self.backgroundOpacity = backgroundOpacity
            self.backgroundColor = backgroundColor
            self.progressViewScaleSize = progressViewScaleSize
            self.progressViewColor = progressViewColor
        }
    }
}

extension View {

    func loading(
        _ isLoading: Bool,
        configuration: Loading.Configuration = .init()
    ) -> some View {
        modifier(Loading(isLoading, configuration: configuration))
    }
}
