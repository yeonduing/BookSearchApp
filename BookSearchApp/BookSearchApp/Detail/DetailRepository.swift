//
//  DetailRepository.swift
//  BookSearchApp
//
//  Created by itzel.du on 2023/06/02.
//

import Foundation
import Combine

protocol DetailRepositoryProtocol {

  func fetchDetails(using isbn13: String) -> AnyPublisher<BookDetail, NetworkService.NetworkError>
}

final class DetailRepository: DetailRepositoryProtocol {

  typealias NetworkError = NetworkService.NetworkError

  private let networkService: NetworkService = .init(session: .shared)

  func fetchDetails(
    using isbn13: String
  ) -> AnyPublisher<BookDetail, NetworkError> {
    guard let url = URL(string: EndPoints.books(isbn13: isbn13).urlString)
    else { return Result.Publisher(NetworkError.invaildURL).eraseToAnyPublisher() }

    return networkService
      .request(request: URLRequest(url: url))
      .decode(type: BookResponse.self, decoder: JSONDecoder())
      .map { BookDetail(bookResponse: $0) }
      .mapError { error -> NetworkError in .failToDecodeJson }
      .eraseToAnyPublisher()
  }
}
