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
        .init(
            id: linkItem.id,
            name: linkItem.name,
            kind: linkItem.kind.rawValue,
            logoUrl: linkItem.logoUrl
        )
    }
}
