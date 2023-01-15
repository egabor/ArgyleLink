//
//  SearchView.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 10..
//

import SwiftUI

struct SearchView<ViewModel: SearchViewModelProtocol>: View {

    @ObservedObject var viewModel: ViewModel
    let configuration: Configuration = .init()

    @FocusState private var isFocused: Bool

    // MARK: - LEVEL 0 Views: Body & Content Wrapper (Main Containers)

    var body: some View {
        content
    }

    var content: some View {
        VStack {
            searchInput
                .padding(.horizontal)
            Divider()
        }
    }

    // MARK: - LEVEL 1 Views: Main UI Elements

    var searchInput: some View {
        HStack(spacing: 0) {
            searchImage
                .padding(configuration.innerPadding)
            textField
                .padding(.vertical, configuration.innerPadding)
            clearButton
                .padding([.vertical, .trailing], configuration.innerPadding)
        }
        .onTapGesture {
            isFocused = true
        }
        .searchFieldStyle()
    }

    // MARK: - LEVEL 2 Views: Helpers & Other Subcomponents

    var searchImage: some View {
        Image.search
    }

    var textField: some View {
        TextField(
            LocalizedStringKey(viewModel.searchFieldPlaceholder),
            text: $viewModel.searchText
        )
        .focused($isFocused)
        .autocorrectionDisabled()
        .accessibilityIdentifier(viewModel.searchViewAccessibilityIdentifier)
    }

    @ViewBuilder
    var clearButton: some View {
        if viewModel.showsClearButton {
            Button(
                action: viewModel.clearSearch,
                label: clearButtonImage
            )
            .transition(.opacity.animation(.easeInOut))
            .accessibilityIdentifier(viewModel.clearButtonAccessibilityIdentifier)
        }
    }

    func clearButtonImage() -> some View {
        Image.clear
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
