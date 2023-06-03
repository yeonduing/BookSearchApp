//
//  DetailViewModel.swift
//  BookSearchApp
//
//  Created by itzel.du on 2023/06/02.
//

import Foundation
import Combine

final class DetailViewModel {

  private let detailBookSubject: CurrentValueSubject<BookDetail?, Never> = .init(nil)

  private let repository: DetailRepositoryProtocol

  private var cancellables: Set<AnyCancellable> = .init()

  init(isbn13: String, repository: DetailRepositoryProtocol) {
    self.repository = repository

    fetchDetailBook(isbn13: isbn13)
  }

  var pdfURLString: String? {
    detailBookSubject.value?.pdf?.values.first
  }

  var urlString: String? {
    detailBookSubject.value?.urlString
  }

  var detailBookPublisher: AnyPublisher<BookDetail?, Never> {
    detailBookSubject.eraseToAnyPublisher()
  }
}

private extension DetailViewModel {

  func fetchDetailBook(isbn13: String) {
    repository.fetchDetails(using: isbn13)
      .sink(receiveCompletion: { error in
        NSLog("DetailViewModel Network request error: \(error)")
      }, receiveValue: { [weak detailBookSubject] in
        detailBookSubject?.send($0)
      })
      .store(in: &cancellables)
  }
}
