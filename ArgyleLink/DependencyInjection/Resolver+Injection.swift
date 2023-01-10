//
//  Resolver+Injection.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 10..
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {

    public static func registerAllServices() {
        register { ImageCache() }
            .implements(ImageCacheProtocol.self)
            .scope(.shared)
    }
}
