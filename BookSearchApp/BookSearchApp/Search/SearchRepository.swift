//
//  SearchRepository.swift
//  BookSearchApp
//
//  Created by itzel.du on 2023/05/31.
//

import Foundation
import Combine

protocol SearchRepositoryProtocol {

  func fetchBooks(using keyword: String, page: Int) -> AnyPublisher<[Book], NetworkService.NetworkError>
}

final class SearchRepository: SearchRepositoryProtocol {

  typealias NetworkError = NetworkService.NetworkError

  private let network: NetworkService = .init(session: .shared)

  func fetchBooks(
    using keyword: String,
    page: Int = 1
  ) -> AnyPublisher<[Book], NetworkError> {
    guard let url = URL(string: EndPoints.search(keyword: keyword, page: page).urlString)
    else { return Result.Publisher(NetworkError.invaildURL).eraseToAnyPublisher() }

    return network
      .request(request: URLRequest(url: url))
      .decode(type: SearchResponse.self, decoder: JSONDecoder())
      .mapError { error -> NetworkError in .failToDecodeJson }
      .map { response -> [Book] in response.books.map { .init(searchBookResponse: $0) } }
      .eraseToAnyPublisher()
  }
}
