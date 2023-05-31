//
//  Book.swift
//  BookSearchApp
//
//  Created by itzel.du on 2023/05/31.
//

import Foundation

struct Book: Equatable {

  let title: String
  let subtitle: String
  let isbn13: String
  let price: String
  let imageURLString: String
  let urlString: String
}

extension Book {

  init(searchBookResponse: SearchBookResponse) {
    title = searchBookResponse.title
    subtitle = searchBookResponse.subtitle
    isbn13 = searchBookResponse.isbn13
    price = searchBookResponse.price
    imageURLString = searchBookResponse.image
    urlString = searchBookResponse.url
  }
}
