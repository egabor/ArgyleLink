//
//  LinkItemToCompanyListItemViewModelMapperUseCase.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 13..
//

import Foundation

protocol LinkItemToCompanyListItemViewModelMapperUseCaseProtocol {

    func callAsFunction(_ linkItem: LinkItemResponse) -> CompanyListItemViewModel
}

class LinkItemToCompanyListItemViewModelMapperUseCase {

    func callAsFunction(_ linkItem: LinkItemResponse) -> CompanyListItemViewModel {
        .init(
            id: linkItem.id,
            name: linkItem.name,
            kind: linkItem.kind.rawValue,
            logoUrl: linkItem.logoUrl
        )
    }
}
