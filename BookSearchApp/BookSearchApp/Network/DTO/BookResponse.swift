//
//  BookResponse.swift
//  BookSearchApp
//
//  Created by itzel.du on 2023/05/31.
//

import Foundation

struct BookResponse: Codable {

  let title: String
  let subtitle: String
  let authors: String
  let publisher: String
  let isbn10: String
  let isbn13: String
  let pages: String
  let year: String
  let rating: String
  let desc: String
  let price: String
  let image: String
  let url: String
  let pdf: [String: String]?
}
