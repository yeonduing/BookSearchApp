//
//  ImageLoader.swift
//  BookSearchApp
//
//  Created by itzel.du on 2023/05/31.
//

import UIKit
import Combine

final class ImageLoader {

  private let imageCache: ImageCache
  private let network: NetworkService

  @Published var image: UIImage? = nil
  private var cancellables: Set<AnyCancellable> = .init()

  init(imageCache: ImageCache, network: NetworkService) {
    self.imageCache = imageCache
    self.network = network
  }

  func fetch(urlString: String) {
    guard image == nil else { return }

    if loadFromCache(urlString: urlString) {
      return
    }

    loadFromUrl(urlString: urlString)
  }
}

private extension ImageLoader {

  func loadFromUrl(urlString: String) {
    guard let url = URL(string: urlString)
    else { return }

    network.request(request: URLRequest(url: url))
      .sink { error in
        NSLog("ImageLoader Network request error: \(error)")
      } receiveValue: { [weak self] data in
        if let image: UIImage = .init(data: data) {
          self?.image = image
          self?.imageCache.store(forKey: urlString, image: image)
        }
      }
      .store(in: &cancellables)
  }

  func loadFromCache(urlString: String) -> Bool {
    guard let image = imageCache.value(forKey: urlString) else {
      return false
    }

    self.image = image

    return true
  }
}
