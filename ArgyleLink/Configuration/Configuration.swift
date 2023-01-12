//
//  Configuration.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 11..
//

import Foundation

enum Configuration: String {
    static let baseUrl = "https://api-sandbox.argyle.com/"
    
    case apiKey = "API_KEY_ID"
    case apiSecret = "API_KEY_SECRET"

    var value: String {
        Bundle.main.infoDictionary?[rawValue] as? String ?? ""
    }
}
