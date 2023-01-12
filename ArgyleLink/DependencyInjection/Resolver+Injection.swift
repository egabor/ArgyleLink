//
//  Resolver+Injection.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 10..
//

import Foundation
import Resolver
import Logging

extension Resolver: ResolverRegistering {

    public static func registerAllServices() {
        registerNetworkServicesAndHelpers()

        register { Logger(label: Configuration.loggerLabel) }
            .scope(.shared)

        register { ImageCache() }
            .implements(ImageCacheProtocol.self)
            .scope(.shared)

        register { _ in
            GetCompaniesUseCase()
        }
        .implements(GetCompaniesUseCaseProtocol.self)
    }

    private static func registerNetworkServicesAndHelpers() {
        register { _ in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }

        register { _ in
            SearchApi(baseUrl: Configuration.baseUrl)
        }
        .implements(SearchApiProtocol.self)
        .scope(.shared)

        register { BasicAuthorizationValueUseCase() }
            .implements(BasicAuthorizationValueUseCaseProtocol.self)
    }
}
