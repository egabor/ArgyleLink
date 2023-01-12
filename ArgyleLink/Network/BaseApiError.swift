//
//  BaseApiError.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 11..
//

import Foundation

enum BaseApiError: Error {
    case urlRequestIsNil
    case urlResponseIsNil
    case invalidStatusCode(Int)
    case other(String?)
    case decoded(ErrorResponse)
}

extension BaseApiError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .other(let string): return string
        case .decoded(let response): return response.detail
        default: return nil
        }
    }
}
