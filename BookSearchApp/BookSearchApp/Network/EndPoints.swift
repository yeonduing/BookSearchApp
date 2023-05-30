//
//  EndPoints.swift
//  BookSearchApp
//
//  Created by itzel.du on 2023/05/31.
//

import Foundation

enum EndPoints {

  case search(keyword: String, page: Int)
  case books(isbn13: String)

  var urlString: String {
    switch self {
    case .search(let keyword, let page):
      return "https://api.itbook.store/1.0/search/\(keyword)/\(page)"

    case .books(let isbn13):
      return "https://api.itbook.store/1.0/books/\(isbn13)"
    }
  }
}
