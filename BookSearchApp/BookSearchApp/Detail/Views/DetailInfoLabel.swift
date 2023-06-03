//
//  DetailInfoLabel.swift
//  BookSearchApp
//
//  Created by itzel.du on 2023/06/01.
//

import UIKit

final class DetailInfoLabel: UILabel {

  init(font: UIFont) {
    super.init(frame: .zero)

    self.font = font

    setupStyle()
  }

  init(frame: CGRect, font: UIFont) {
    super.init(frame: frame)

    self.font = font

    setupStyle()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(with text: String) {
    self.text = text

    sizeToFit()
  }
}

private extension DetailInfoLabel {

  func setupStyle() {
    numberOfLines = 0
    lineBreakMode = .byWordWrapping
    textColor = .primary
    backgroundColor = .clear
  }
}
