//
//  AsyncImageViewModel.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 10..
//

import Foundation
import Combine
import UIKit.UIImage
import Resolver

class AsyncImageViewModel: ObservableObject {

    private static let imageProcessingQueue = DispatchQueue(label: "image-processing")

    @Injected private var cache: ImageCacheProtocol

    @Published var image: UIImage?
    private(set) var isLoading = false
    private var cancellable: AnyCancellable?

    private let url: URL?

    init(url: URL?) {
        self.url = url
    }

    deinit {
        cancel()
    }

    func loadImage() {
        guard !isLoading else { return }
        guard let url = url else { return }

        if let image = cache[url] {
            self.image = image
            return
        }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(
                receiveSubscription: { [weak self] _ in self?.onStart() },
                receiveOutput: { [weak self] in self?.saveImageToCache($0) },
                receiveCompletion: { [weak self] _ in self?.onFinish() },
                receiveCancel: { [weak self] in self?.onFinish() }
            )
            .subscribe(on: Self.imageProcessingQueue)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }

    private func cancel() {
        cancellable?.cancel()
    }

    private func onStart() {
        isLoading = true
    }

    private func onFinish() {
        isLoading = false
    }

    private func saveImageToCache(_ image: UIImage?) {
        guard let url = url else { return }
        cache[url] = image
    }
}
