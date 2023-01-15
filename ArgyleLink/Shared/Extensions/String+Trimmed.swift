//
//  String+Trimmed.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 15..
//

import Foundation

extension String {

    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
