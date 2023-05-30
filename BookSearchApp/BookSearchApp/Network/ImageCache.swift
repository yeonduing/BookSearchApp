//
//  ImageCache.swift
//  BookSearchApp
//
//  Created by itzel.du on 2023/05/31.
//

import UIKit

final class ImageCache {
  private let cache: NSCache<NSString, UIImage> = .init()

  init(
    totalCostLimit: Int = 50 * 1024 * 1024,
    countLimit: Int = 1000
  ) {
    cache.totalCostLimit = totalCostLimit
    cache.countLimit = countLimit
  }

  deinit {
    removeAll()
  }

  func value(forKey key: String) -> UIImage? {
    return cache.object(forKey: NSString(string: key))
  }

  func store(forKey key: String, image: UIImage) {
    cache.setObject(image, forKey: NSString(string: key))
  }

  func remove(forKey key: String) {
    cache.removeObject(forKey: key as NSString)
  }

  func removeAll() {
    cache.removeAllObjects()
  }
}
