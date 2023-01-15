//
//  MockSearchResult.swift
//  ArgyleLinkTests
//
//  Created by Eszenyi Gábor on 2023. 01. 15..
//

import Foundation

enum MockSearchResult: String {
    case successNoResults = "search:link-items_200_noResults.json"
    case successValidResults = "search:link-items_200_validResults.json"
    case successInvalidResults = "search:link-items_200_invalidResults.json"
    case failure
}
