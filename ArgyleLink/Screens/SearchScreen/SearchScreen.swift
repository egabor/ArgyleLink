//
//  SearchScreen.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 10..
//

import SwiftUI

struct SearchScreen: View {

    @StateObject private var viewModel: SearchScreenModel = .init()

    // MARK: - LEVEL 0 Views: Body & Content Wrapper (Main Containers)

    var body: some View {
        content
            .alert(
                LocalizedStringKey(viewModel.errorAlertTitle),
                isPresented: $viewModel.showError,
                actions: errorAlertActions,
                message: errorAlertMessage
            )
    }

    var content: some View {
        VStack(spacing: 0) {
            SearchView(viewModel: viewModel)
            CompanyListView(viewModel: viewModel)
        }
    }

    // MARK: - LEVEL 1 Views: Main UI Elements

    // MARK: - LEVEL 2 Views: Helpers & Other Subcomponents

    func errorAlertActions() -> some View {
        Text(LocalizedStringKey(viewModel.errorAlertOkButtonTitle))
    }

    func errorAlertMessage() -> some View {
        Text(viewModel.errorMessage)
    }
}

struct SearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreen()
    }
}
