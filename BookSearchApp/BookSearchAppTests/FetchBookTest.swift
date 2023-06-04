//
//  FetchBookTest.swift
//  FetchBookTest
//
//  Created by itzel.du on 2023/05/30.
//

import XCTest
import Combine
@testable import BookSearchApp

final class FetchBookTest: XCTestCase {

  var repository: SearchRepository!
  var cancellables: Set<AnyCancellable>!

  override func setUp() {
    super.setUp()

    repository = .init()
    cancellables = .init()
  }

  override func tearDown() {
    cancellables.forEach { $0.cancel() }
    cancellables.removeAll()

    super.tearDown()
  }

  func test_영어키워드가_Swift인_경우() {
    let expactation = XCTestExpectation(description: "EnglishKeywordSwift")
    repository.fetchBooks(using: "Swift")
      .sink(receiveCompletion: { result in
        switch result {
        case .finished:
          expactation.fulfill()
        case .failure(_):
          XCTExpectFailure()
        }
      }, receiveValue: {
        XCTAssertEqual($0.isEmpty, false)
      }
      )
      .store(in: &cancellables)


    wait(for: [expactation], timeout: 10.0)
  }

  func test_한글키워드_스위프트인_경우() {
    let expactation = XCTestExpectation(description: "KoreanKeyword스위프트")
    repository.fetchBooks(using: "스위프트")
      .sink { result in
        switch result {
        case .finished:
          XCTFail()
        case .failure(let error):
          XCTAssertEqual(error, .invaildURL)
          expactation.fulfill()
        }
      } receiveValue: { _ in
        XCTFail()
      }
      .store(in: &cancellables)

    wait(for: [expactation], timeout: 10.0)
  }
}
