//
//  LinkItemResponse.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 11..
//

import Foundation

struct LinkItemResponse: Decodable {

    enum Kind: String, Decodable {
        case employer, gig, platform, creator, benefits
        case unknown

        init(from decoder: Decoder) throws {
            self = try Kind(
                rawValue: decoder.singleValueContainer().decode(RawValue.self)
            ) ?? .unknown
        }
    }

    let id: String
    let name: String
    let kind: Kind
    let logoUrl: String
}
