//
//  SearchViewModel.swift
//  BookSearchApp
//
//  Created by itzel.du on 2023/05/31.
//

import Foundation
import Combine

final class SearchViewModel {

  let imageCache: ImageCache
  let network: NetworkService

  private let repository: SearchRepositoryProtocol

  private let booksSubject: CurrentValueSubject<[Book], Never> = .init([])

  private var fetchingCancellable: AnyCancellable?
  private var currentPage: Int = 1
  private var isFetching: Bool = false
  private var keyword: String = ""

  init(
    repository: SearchRepositoryProtocol,
    imageCache: ImageCache = .init(),
    network: NetworkService = .init(session: .shared)
  ) {
    self.repository = repository
    self.imageCache = imageCache
    self.network = network
  }
}

extension SearchViewModel {

  func fetchBooks(using keyword: String? = nil) {
    guard !isFetching else { return }

    isFetching = true
    currentPage += 1

    if let keyword {
      removeBooks()
      currentPage = 1
      self.keyword = keyword
    }

    let keyword = keyword ?? self.keyword

    fetchingCancellable = repository.fetchBooks(using: keyword, page: currentPage)
      .map { [weak booksSubject] (fetchedBooks) -> [Book] in
        let books = (booksSubject?.value ?? []) + fetchedBooks

        return books
      }
      .sink(receiveCompletion: { [weak self] _ in
        self?.isFetching = false
      }, receiveValue: { [weak booksSubject] in
        booksSubject?.send($0)
      })
  }

  func removeBooks() {
    booksSubject.send([])
    fetchingCancellable?.cancel()
    isFetching = false
  }

  var booksPublisher: AnyPublisher<[Book], Never> {
    booksSubject.eraseToAnyPublisher()
  }

  var bookCount: Int {
    booksSubject.value.count
  }

  var books: [Book] {
    booksSubject.value
  }
}
