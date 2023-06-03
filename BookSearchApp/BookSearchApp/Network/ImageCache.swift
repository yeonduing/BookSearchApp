//
//  ImageCache.swift
//  BookSearchApp
//
//  Created by itzel.du on 2023/05/31.
//

import UIKit

protocol ImageCacheable {

  func value(forKey key: String) -> UIImage?
  func store(forKey key: String, image: UIImage)
  func remove(forKey key: String)
  func removeAll()
}

final class ImageMemoryCache: ImageCacheable {
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

final class ImageDiskCache: ImageCacheable {

  private let fileManager: FileManager
  private let queue: DispatchQueue

  init(fileManager: FileManager = .default, queue: DispatchQueue = .global()) {
    self.fileManager = fileManager
    self.queue = queue
  }

  func value(forKey key: String) -> UIImage? {
    let fileURL = fileURL(forKey: key)
    guard let data = try? Data(contentsOf: fileURL) else { return nil }

    return UIImage(data: data)
  }

  func store(forKey key: String, image: UIImage) {
    let fileURL = fileURL(forKey: key)
    let data = try? JSONEncoder().encode(image.pngData())
    try? data?.write(to: fileURL)
  }

  func remove(forKey key: String) {
    let fileURL = fileURL(forKey: key)
    try? fileManager.removeItem(at: fileURL)
  }

  func removeAll() {
    try? fileManager.removeItem(at: directoryURL)
  }
}

private extension ImageDiskCache {

  func fileURL(forKey key: String) -> URL {
    let fileURL = directoryURL.appendingPathComponent(key + ".cache")

    return fileURL
  }

  var directoryURL: URL {
    let directoryURLs = fileManager.urls(
      for: .cachesDirectory,
      in: .userDomainMask
    )

    return directoryURLs[0]
  }
}
