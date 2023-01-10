//
//  SearchButtonStyle.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 10..
//

import SwiftUI

struct SearchButtonStyle: ButtonStyle {

    @Environment(\.isEnabled) private var isEnabled

    var animation: Animation {
        return .easeInOut(duration: styleConfiguration.scaleEffectAnimationDuration)
    }

    let styleConfiguration: StyleConfiguration

    init(styleConfiguration: StyleConfiguration = .init()) {
        self.styleConfiguration = styleConfiguration
    }

    // MARK: Content Composing Methods

    func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed
        view(for: configuration)
            .background(backgroundColor(for: state(isPressed)))
            .foregroundColor(foregroundColor(for: state(isPressed)))
            .scaleEffect(scaleEffectValue(for: state(isPressed)))
            .animation(animation, value: isPressed)
    }

    func view(for configuration: Configuration) -> some View {
        configuration.label
            .font(styleConfiguration.font)
            .padding(styleConfiguration.buttonPadding)
    }

    // MARK: - State Helper

    func state(_ isPressed: Bool? = nil) -> ButtonState {
        guard isEnabled else { return .disabled }
        guard let isPressed = isPressed, isPressed else { return .normal }
        return .highlighted
    }

    // MARK: - State Based Properties

    func backgroundColor(for state: ButtonState) -> Color {
        switch state {
        case .disabled:     return .searchButtonDisabledBackground
        case .highlighted:  return .searchButtonHighlightedBackground
        default:            return .searchButtonNormalBackground
        }
    }

    func foregroundColor(for state: ButtonState) -> Color {
        switch state {
        case .disabled:     return .searchButtonDisabledTitle
        case .highlighted:  return .searchButtonHighlightedTitle
        default:            return .searchButtonNormalTitle
        }
    }

    func scaleEffectValue(for state: ButtonState) -> CGFloat {
        switch state {
        case .highlighted:  return styleConfiguration.highlightedScaleEffect
        default:            return styleConfiguration.normalScaleEffect
        }
    }
}

extension SearchButtonStyle {

    enum ButtonState {

        case normal
        case highlighted
        case disabled
    }
}

extension SearchButtonStyle {

    struct StyleConfiguration {

        let font: Font
        let highlightedScaleEffect: Double
        let normalScaleEffect: Double

        let scaleEffectAnimationDuration: Double = 0.2
        let buttonPadding: Double = 6.0

        init(
            font: Font = .system(size: 17, weight: .regular),
            highlightedScaleEffect: Double = 0.98,
            normalScaleEffect: Double = 1
        ) {
            self.font = font
            self.highlightedScaleEffect = highlightedScaleEffect
            self.normalScaleEffect = normalScaleEffect
        }
    }
}

extension View {

    func searchButtonStyle(
        styleConfiguration: SearchButtonStyle.StyleConfiguration = .init()
    ) -> some View {
        buttonStyle(SearchButtonStyle(styleConfiguration: styleConfiguration))
    }
}
