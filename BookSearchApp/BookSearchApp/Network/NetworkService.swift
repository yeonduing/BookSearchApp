//
//  NetworkService.swift
//  BookSearchApp
//
//  Created by itzel.du on 2023/05/31.
//

import Foundation
import Combine

final class NetworkService {

  enum NetworkError: Error, Equatable {
    case invaildURL
    case failToDecodeJson
    case invalidRequest
    case unknownError(message: String)
  }

  private let session: URLSession

  init(session: URLSession) {
    self.session = session
  }

  func request(request: URLRequest) -> AnyPublisher<Data, NetworkError> {
    return session.dataTaskPublisher(for: request)
      .tryMap { data, response -> Data in
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode)
        else {
          throw NetworkError.invalidRequest
        }
        return data
      }
      .mapError { error -> NetworkError in
          .unknownError(message: error.localizedDescription)
      }
      .eraseToAnyPublisher()
  }

  deinit {
    session.invalidateAndCancel()
  }
}
