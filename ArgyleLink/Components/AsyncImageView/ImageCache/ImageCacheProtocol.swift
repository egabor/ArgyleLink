//
//  ImageCacheProtocol.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 10..
//

import Foundation
import UIKit.UIImage

protocol ImageCacheProtocol {
    subscript(_ url: URL) -> UIImage? { get set }
}
