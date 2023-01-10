//
//  SearchView.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 10..
//

import SwiftUI

struct SearchView<ViewModel: SearchViewModelProtocol>: View {

    @ObservedObject var viewModel: ViewModel
    var configuration: Configuration = .init()

    @FocusState private var isFocused: Bool

    // MARK: - LEVEL 0 Views: Body & Content Wrapper (Main Containers)

    var body: some View {
        content
    }

    var content: some View {
        VStack {
            searchField
                .padding(.horizontal)
            Divider()
        }
    }

    // MARK: - LEVEL 1 Views: Main UI Elements

    var searchField: some View {
        HStack {
            searchInput
            searchButton
        }
    }

    // MARK: - LEVEL 2 Views: Helpers & Other Subcomponents

    var searchInput: some View {
        HStack(spacing: 0) {
            textField
                .padding([.leading, .vertical], configuration.innerPadding)
            clearButton
                .padding([.vertical, .trailing], configuration.innerPadding)
        }
        .onTapGesture {
            isFocused = true
        }
        .searchFieldStyle()
        .disabled(viewModel.isSearchFieldDisabled)
    }

    var textField: some View {
        TextField(
            LocalizedStringKey(viewModel.searchFieldPlaceholder),
            text: $viewModel.searchText
        )
        .focused($isFocused)
        .onSubmit {
            viewModel.search()
        }
    }

    @ViewBuilder
    var clearButton: some View {
        if viewModel.showsClearButton {
            Button(
                action: viewModel.clearSearch,
                label: clearButtonImage
            )
            .transition(.opacity.animation(.easeInOut))
        }
    }

    func clearButtonImage() -> some View {
        Image.clear
    }

    var searchButton: some View {
        Button(
            LocalizedStringKey(viewModel.searchButtonTitle),
            action: viewModel.search
        )
        .searchButtonStyle()
        .disabled(viewModel.isSearchDisabled)
    }
}

extension SearchView {

    struct Configuration {

        let innerPadding: Double

        init(
            innerPadding: Double = 10.0
        ) {
            self.innerPadding = innerPadding
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: PreviewSearchViewModel())
    }
}
