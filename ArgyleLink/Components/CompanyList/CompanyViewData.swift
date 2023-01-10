//
//  CompanyViewData.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 10..
//

import SwiftUI

struct CompanyViewData: Identifiable {
    let id: String
    let name: String // TODO: Check if this is optional or not
    let kind: String // TODO: Check if this is optional or not // TODO: Check if this is an enum or not
    let logoUrl: String // TODO: Check if this is optional or not
}

// TODO: Create an own file for the view
extension CompanyViewData: View {

    var imageSize: CGFloat { 50 } // TODO: Config!
    var verticalPadding: CGFloat { 4 } // TODO: Config!

    // MARK: - LEVEL 0 Views: Body & Content Wrapper (Main Containers)

    var body: some View {
        content
            .padding(.horizontal)
    }

    var content: some View {
        HStack {
            imageView
                .frame(width: imageSize, height: imageSize)
            VStack(alignment: .leading, spacing: 4) {
                loginText
                typeTag
            }
            Spacer()
        }
        .padding(.vertical, verticalPadding)
    }

    // MARK: - LEVEL 1 Views: Main UI Elements

    @ViewBuilder
    var imageView: some View {
        AsyncImageView(
            url: URL(string: logoUrl),
            placeholder: {
                ProgressView()
                    .frame(width: imageSize, height: imageSize)
            },
            image: {
                Image(uiImage: $0)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imageSize, height: imageSize)
                    .background(Color.white)
            }
        )
        .cornerRadius(12) // TODO: Config!
    }

    var loginText: some View {
        Text(name)
    }

    var typeTag: some View {
        Text(kind)
    }
}

// swiftlint:disable line_length
extension Array where Element == CompanyViewData {

    static var previewArray: Self {
        [
            .init(id: "amazon", name: "Amazon", kind: "employer", logoUrl: "https://res.cloudinary.com/argyle-media/image/upload/v1598543068/partner-logos/amazon.png"),
            .init(id: "amazon_flex", name: "Amazon Flex", kind: "gig", logoUrl: "https://res.cloudinary.com/argyle-media/image/upload/v1566985961/partner-logos/amazon_flex.png"),
            .init(id: "amazon_warehouse", name: "Amazon Warehouse", kind: "employer", logoUrl: "https://res.cloudinary.com/argyle-media/image/upload/v1587740725/partner-logos/amazon_warehouse.png"),
            .init(id: "amazon_hose_and_rubber", name: "Amazon Hose And Rubber", kind: "employer", logoUrl: "https://res.cloudinary.com/argyle-media/image/upload/v1617706054/partner-logos/amazon_hose_and_rubber.png"),
            .init(id: "al_anon_family_groups", name: "Al-Anon Family Groups", kind: "employer", logoUrl: "https://res.cloudinary.com/argyle-media/image/upload/v1618223247/partner-logos/al_anon_family_groups.png")
        ]
    }
}
// swiftlint:enable line_length
