//
//  BasicAuthorizationValueUseCase.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 11..
//

import Foundation

protocol BasicAuthorizationValueUseCaseProtocol {

    func callAsFunction(username: String, password: String) -> String
}

class BasicAuthorizationValueUseCase: BasicAuthorizationValueUseCaseProtocol {

    func callAsFunction(username: String, password: String) -> String {
        let authorizationData = username + ":" + password
        let encodedData = authorizationData.data(using: .utf8)?.base64EncodedString() ?? ""
        return "Basic \(encodedData)"
    }
}
