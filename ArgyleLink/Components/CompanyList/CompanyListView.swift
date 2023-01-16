//
//  CompanyListView.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 10..
//

import SwiftUI

struct CompanyListView<ViewModel: CompanyListViewModelProtocol>: View {

    @ObservedObject var viewModel: ViewModel
    let configuration: Configuration = .init()

    // MARK: - LEVEL 0 Views: Body & Content Wrapper (Main Containers)

    var body: some View {
        content
    }

    @ViewBuilder
    var content: some View {
        Group {
            if viewModel.isLoading {
                list(with: .placeholderData)
                    .redacted(reason: .placeholder)
                    .accessibilityIdentifier(viewModel.placeholderCompanyListAccessibilityId)
            } else if viewModel.isEmpty {
                emptyList
            } else {
                list(with: viewModel.companies)
                    .accessibilityIdentifier(viewModel.companyListAccessibilityId)
            }
        }
        .scrollDismissesKeyboard(.immediately)
        .transition(.opacity.animation(.easeInOut))
    }

    // MARK: - LEVEL 1 Views: Main UI Elements

    func list(with data: [CompanyListItemViewModel]) -> some View {
        ScrollView {
            LazyVStack(
                alignment: .leading,
                spacing: configuration.listItemSpacing
            ) {
                ForEach(data) { CompanyListItem(viewModel: $0) }
            }
        }
    }

    var emptyList: some View {
        VStack {
            Spacer()
            if viewModel.hasNoResultsForKeyword {
                noResultsState
                    .accessibilityElement(children: .combine)
                    .accessibilityIdentifier(viewModel.noResultsEmptyStateAccessibilityId)
            } else {
                emptyState
                    .accessibilityElement(children: .combine)
                    .accessibilityIdentifier(viewModel.initialEmptyStateAccessibilityId)
            }
            Spacer()
        }
    }

    // MARK: - LEVEL 2 Views: Helpers & Other Subcomponents

    var emptyState: some View {
        VStack {
            Image.search
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(
                    width: configuration.emptyListIconSize,
                    height: configuration.emptyListIconSize
                )
                .padding(.bottom)
            Text(LocalizedStringKey(viewModel.emptyListText))
                .multilineTextAlignment(.center)
        }
    }

    var noResultsState: some View {
        VStack {
            Text("🤔")
                .font(.system(size: configuration.emptyListIconSize))
            Text(LocalizedStringKey(viewModel.emptyListText))
                .multilineTextAlignment(.center)
        }
    }
}

extension CompanyListView {

    struct Configuration {

        let emptyListIconSize: Double
        let listItemSpacing: Double

        init(
            emptyListIconSize: Double = 64.0,
            listItemSpacing: Double = 0.0
        ) {
            self.emptyListIconSize = emptyListIconSize
            self.listItemSpacing = listItemSpacing
        }
    }
}

struct CompanyListView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            CompanyListView(viewModel: PreviewCompanyListViewModel.empty)
            CompanyListView(viewModel: PreviewCompanyListViewModel.someItems)

            CompanyListView(viewModel: PreviewCompanyListViewModel.empty)
                .preferredColorScheme(.dark)
            CompanyListView(viewModel: PreviewCompanyListViewModel.someItems)
                .preferredColorScheme(.dark)
        }
    }
}
