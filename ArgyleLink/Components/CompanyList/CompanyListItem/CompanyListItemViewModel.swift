//
//  CompanyListItemViewModel.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 10..
//

import SwiftUI

struct CompanyListItemViewModel: Identifiable, Equatable {
    let id: String
    let name: String
    let kind: String
    let logoUrl: URL?
}

// swiftlint:disable line_length
extension Array where Element == CompanyListItemViewModel {

    static var previewArray: Self {
        [
            .init(id: "amazon", name: "Amazon", kind: "employer", logoUrl: URL(string: "https://res.cloudinary.com/argyle-media/image/upload/v1598543068/partner-logos/amazon.png")),
            .init(id: "amazon_flex", name: "Amazon Flex", kind: "gig", logoUrl: URL(string: "https://res.cloudinary.com/argyle-media/image/upload/v1566985961/partner-logos/amazon_flex.png")),
            .init(id: "amazon_warehouse", name: "Amazon Warehouse", kind: "employer", logoUrl: URL(string: "https://res.cloudinary.com/argyle-media/image/upload/v1587740725/partner-logos/amazon_warehouse.png")),
            .init(id: "amazon_hose_and_rubber", name: "Amazon Hose And Rubber", kind: "employer", logoUrl: URL(string: "https://res.cloudinary.com/argyle-media/image/upload/v1617706054/partner-logos/amazon_hose_and_rubber.png")),
            .init(id: "al_anon_family_groups", name: "Al-Anon Family Groups", kind: "employer", logoUrl: URL(string: "https://res.cloudinary.com/argyle-media/image/upload/v1618223247/partner-logos/al_anon_family_groups.png"))
        ]
    }

    static var placeholderData: Self {
        [
            .init(id: "01", name: "Amazon", kind: "employer", logoUrl: nil),
            .init(id: "02", name: "Amazon Flex", kind: "gig", logoUrl: nil),
            .init(id: "03", name: "Amazon Warehouse", kind: "employer", logoUrl: nil),
            .init(id: "04", name: "Amazon Hose And Rubber", kind: "employer", logoUrl: nil),
            .init(id: "05", name: "Al-Anon Family Groups", kind: "employer", logoUrl: nil),
            .init(id: "06", name: "Amazon", kind: "employer", logoUrl: nil),
            .init(id: "07", name: "Amazon Flex", kind: "gig", logoUrl: nil),
            .init(id: "08", name: "Amazon Warehouse", kind: "employer", logoUrl: nil),
            .init(id: "09", name: "Amazon Hose And Rubber", kind: "employer", logoUrl: nil),
            .init(id: "10", name: "Al-Anon Family Groups", kind: "employer", logoUrl: nil)
        ]
    }
}
// swiftlint:enable line_length
