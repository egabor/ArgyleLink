//
//  Configuration.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 11..
//

import Foundation

enum Configuration: String {
    static let baseUrl = "https://api-sandbox.argyle.com/"
    static let loggerLabel = "argyle-link"
    static var minimumInputCharacters: Int = 2

    case apiKey = "API_KEY_ID"
    case apiSecret = "API_KEY_SECRET"

    var value: String {
        guard let configurationValue = Bundle.main.infoDictionary?[rawValue] as? String,
              configurationValue.isEmpty == false
        else {
            assertionFailure(file: "Configuration value cannot be nil or empty.")
            return ""
        }
        return configurationValue
    }
}
