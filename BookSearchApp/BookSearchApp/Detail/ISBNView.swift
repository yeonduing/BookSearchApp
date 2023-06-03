//
//  ISBNView.swift
//  BookSearchApp
//
//  Created by itzel.du on 2023/06/01.
//

import UIKit

final class ISBNView: UIView {

  private let isbn10Label: DetailInfoLabel = .init(font: .detailIsbn)
  private let isbn13Label: DetailInfoLabel = .init(font: .detailIsbn)

  override init(frame: CGRect) {
    super.init(frame: .zero)

    setupStyle()
    setupLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(withISBN10 isbn10: String, isbn13: String) {
    isbn10Label.text = "ISBN10 | \(isbn10)"
    isbn13Label.text = "ISBN13 | \(isbn13)"
  }
}

private extension ISBNView {

  func setupStyle() {
    isbn10Label.textColor = .primary
    isbn10Label.textAlignment = .right
    isbn10Label.sizeToFit()

    isbn13Label.textColor = .primary
    isbn13Label.textAlignment = .right
    isbn13Label.sizeToFit()
  }

  func setupLayout() {
    [isbn10Label, isbn13Label].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }

    NSLayoutConstraint.activate([
      isbn10Label.topAnchor.constraint(equalTo: topAnchor),
      isbn10Label.leadingAnchor.constraint(equalTo: leadingAnchor),
      isbn10Label.trailingAnchor.constraint(equalTo: trailingAnchor),

      isbn13Label.topAnchor.constraint(equalTo: isbn10Label.bottomAnchor),
      isbn13Label.leadingAnchor.constraint(equalTo: isbn10Label.leadingAnchor),
      isbn13Label.trailingAnchor.constraint(equalTo: isbn10Label.trailingAnchor),
      isbn13Label.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}

