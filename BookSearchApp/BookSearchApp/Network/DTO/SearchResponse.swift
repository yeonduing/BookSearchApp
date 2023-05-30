//
//  SearchResponse.swift
//  BookSearchApp
//
//  Created by itzel.du on 2023/05/31.
//

import Foundation

struct SearchResponse: Decodable {

  let error: String
  let total: String
  let page: String
  let books: [SearchBookResponse]
}

struct SearchBookResponse: Codable, Hashable {

  let title: String
  let subtitle: String
  let isbn13: String
  let price: String
  let image: String
  let url: String
}
