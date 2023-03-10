//
//  CompanyListItem.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 11..
//

import SwiftUI

struct CompanyListItem: View {

    let viewModel: CompanyListItemViewModel
    let configuration: Configuration = .init()

    // MARK: - LEVEL 0 Views: Body & Content Wrapper (Main Containers)

    var body: some View {
        content
            .padding(.horizontal)
    }

    var content: some View {
        HStack {
            imageView
                .frame(
                    width: configuration.imageSize,
                    height: configuration.imageSize
                )
            VStack(alignment: .leading, spacing: 4) {
                nameText
                kindText
            }
            Spacer()
        }
        .padding(.vertical, configuration.verticalPadding)
    }

    // MARK: - LEVEL 1 Views: Main UI Elements

    @ViewBuilder
    var imageView: some View {
        if let url = viewModel.logoUrl {
            AsyncImageView(
                url: url,
                placeholder: placeholder,
                image: image
            )
            .cornerRadius(configuration.imageCornerRadius)
        } else {
            Rectangle()
                .frame(
                    width: configuration.imageSize,
                    height: configuration.imageSize
                )
                .foregroundColor(Color.black.opacity(0.1))
                .cornerRadius(configuration.imageCornerRadius)
        }
    }

    var nameText: some View {
        Text(viewModel.name)
    }

    var kindText: some View {
        Text(viewModel.kind)
    }

    // MARK: - LEVEL 2 Views: Helpers & Other Subcomponents

    func placeholder() -> some View {
        ProgressView()
            .frame(
                width: configuration.imageSize,
                height: configuration.imageSize
            )
    }

    func image(_ image: UIImage) -> some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(
                width: configuration.imageSize,
                height: configuration.imageSize
            )
            .background(Color.white)
    }
}

extension CompanyListItem {

    struct Configuration {

        let verticalPadding: Double
        let imageSize: Double
        let imageCornerRadius: Double

        init(
            verticalPadding: Double = 4.0,
            imageSize: Double = 50.0,
            imageCornerRadius: Double = 12.0
        ) {
            self.verticalPadding = verticalPadding
            self.imageSize = imageSize
            self.imageCornerRadius = imageCornerRadius
        }
    }
}

struct CompanyListItem_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            CompanyListItem(
                viewModel: .init(
                    id: "test",
                    name: "Test",
                    kind: "Employer",
                    // swiftlint:disable:next line_length
                    logoUrl: URL(string: "https://res.cloudinary.com/argyle-media/image/upload/v1598543068/partner-logos/amazon.png")
                )
            )
        }
    }
}
