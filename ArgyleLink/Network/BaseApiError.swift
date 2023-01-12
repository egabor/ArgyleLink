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
    case invalidStatusCode(Int, String?)
    case invalidResponseBody(Data?)
    case other(String?)
}
