//
//  SearchApiProtocol.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 11..
//

import Foundation
import Combine

protocol SearchApiProtocol {

    func getLinkItems(for searchExpression: String, limit: Int) -> AnyPublisher<LinkItemsResponse, Error>
}
