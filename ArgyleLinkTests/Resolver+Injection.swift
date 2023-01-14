//
//  Resolver+Injection.swift
//  ArgyleLinkTests
//
//  Created by Eszenyi Gábor on 2023. 01. 13..
//

import Foundation
import Resolver
@testable import ArgyleLink

extension Resolver {
    static var unitTests: Resolver!

    static func resetUnitTestRegistrations() {
        Resolver.reset()
        Resolver.defaultScope = .shared

        Resolver.unitTests = .init(child: .main)
        Resolver.root = .unitTests

        Resolver.unitTests.register { MockSearchApi() }
            .implements(SearchApiProtocol.self)
            .scope(.shared)
    }
}
