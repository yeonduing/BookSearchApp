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

struct BookDetail {

  let title: String
  let subtitle: String
  let authors: String
  let publisher: String
  let isbn10: String
  let isbn13: String
  let pages: String
  let year: String
  let rating: Int
  let descriptionString: String
  let price: String
  let imageURLString: String
  let urlString: String
  let pdf: [String: String]?
}

extension BookDetail {

  init(bookResponse: BookResponse) {
    title = bookResponse.title
    subtitle = bookResponse.subtitle
    authors = bookResponse.authors
    publisher = bookResponse.publisher
    isbn10 = bookResponse.isbn10
    isbn13 = bookResponse.isbn13
    pages = bookResponse.pages
    year = bookResponse.year
    rating = Int(bookResponse.rating) ?? 0
    descriptionString = bookResponse.desc
    price = bookResponse.price
    imageURLString = bookResponse.image
    urlString = bookResponse.url
    pdf = bookResponse.pdf
  }
}

struct BookSummary {

  let rating: String
  let pages: String
  let year: String
}
