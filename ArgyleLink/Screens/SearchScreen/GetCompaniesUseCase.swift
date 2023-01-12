//
//  GetLinkItems.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 12..
//

import Foundation
import Resolver

protocol GetCompaniesUseCaseProtocol {

    func callAsFunction(for searchExpression: String) async throws -> [CompanyListItemViewModel]
}

class GetCompaniesUseCase: GetCompaniesUseCaseProtocol {

    let maximumNumberOfSearchResults = 15
    @Injected private var searchApi: SearchApiProtocol

    func callAsFunction(for searchExpression: String) async throws -> [CompanyListItemViewModel] {
        let result = try await searchApi.getLinkItems(
            for: searchExpression,
            limit: maximumNumberOfSearchResults
        )
        return result.results.compactMap { [weak self] linkItem in
            self?.companyListItemViewModel(from: linkItem)
        }
    }

    func companyListItemViewModel(from linkItem: LinkItemResponse) -> CompanyListItemViewModel {
        .init(
            id: linkItem.id,
            name: linkItem.name,
            kind: linkItem.kind.rawValue,
            logoUrl: linkItem.logoUrl
        )
    }
}
