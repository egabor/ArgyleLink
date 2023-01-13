//
//  GetCompaniesUseCase.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 12..
//

import Foundation
import Resolver
import Combine

protocol GetCompaniesUseCaseProtocol {

    func callAsFunction(for searchExpression: String) -> AnyPublisher<[CompanyListItemViewModel], Error>
}

class GetCompaniesUseCase: GetCompaniesUseCaseProtocol {

    let maximumNumberOfSearchResults = 15
    @Injected private var searchApi: SearchApiProtocol
    @Injected private var mapLinkItem: LinkItemToCompanyListItemViewModelMapperUseCaseProtocol

    func callAsFunction(for searchExpression: String) -> AnyPublisher<[CompanyListItemViewModel], Error> {
        return Just(searchExpression)
            .flatMap { [weak self] searchExpression in
                guard let self = self else { return
                    Just(LinkItemsResponse(results: []))
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                }
                return self.searchApi.getLinkItems(
                    for: searchExpression,
                    limit: self.maximumNumberOfSearchResults
                )
                    .receive(on: DispatchQueue.main)
                    .eraseToAnyPublisher()
            }
            .map { response in
                response.results.compactMap { [weak self] linkItem in
                    self?.mapLinkItem(linkItem)
                }
            }
            .eraseToAnyPublisher()
    }
}
