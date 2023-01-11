//
//  PreviewCompanyListViewModel.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 10..
//

import Combine

class PreviewCompanyListViewModel: CompanyListViewModelProtocol {

    var companies: [CompanyListItemViewModel] = []
    var mostRecentSearchText: String = ""

    var isEmpty: Bool {
        companies.isEmpty
    }

    init(companies: [CompanyListItemViewModel]) {
        self.companies = companies
    }
}

extension PreviewCompanyListViewModel {

    public static let empty: PreviewCompanyListViewModel = .init(companies: [])

    public static let someItems: PreviewCompanyListViewModel = .init(
        companies: .previewArray
    )
}
