//
//  LinkItemMapperUseCase.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 13..
//

import Foundation

protocol LinkItemMapperUseCaseProtocol {

    func callAsFunction(_ linkItem: LinkItemResponse) -> CompanyListItemViewModel
}

class LinkItemMapperUseCase: LinkItemMapperUseCaseProtocol {

    func callAsFunction(_ linkItem: LinkItemResponse) -> CompanyListItemViewModel {
        var logoUrl: URL?
        if let urlString = linkItem.logoUrl, let url = URL(string: urlString) {
            logoUrl = url
        }

        return .init(
            id: linkItem.id,
            name: linkItem.name,
            kind: linkItem.kind.rawValue,
            logoUrl: logoUrl
        )
    }
}
