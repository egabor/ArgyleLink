//
//  ErrorCapable.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 12..
//

import Foundation

protocol ErrorCapable: AnyObject {

    var showError: Bool { get set }
    var errorMessage: String { get set }
}

extension ErrorCapable {

    var errorAlertTitle: String {
        .alertErrorTitle
    }

    var errorAlertOkButtonTitle: String {
        .alertOkButtonTitle
    }
}
