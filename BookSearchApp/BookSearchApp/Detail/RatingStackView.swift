//
//  RatingStackView.swift
//  BookSearchApp
//
//  Created by itzel.du on 2023/06/01.
//

import UIKit

final class RatingStackView: UIStackView {

  private let firstStar: StarImageView = .init()
  private let secondStar: StarImageView = .init()
  private let thirdStar: StarImageView = .init()
  private let fourthStar: StarImageView = .init()
  private let fifthStar: StarImageView = .init()

  init() {
    super.init(frame: .zero)

    setupStyle()
    setupLayout()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupStyle()
    setupLayout()
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(with rating: Int) {
    let stars = [firstStar, secondStar, thirdStar, fourthStar, fifthStar]

    (0..<rating).forEach { index in
      stars[index].fillStar()
    }
  }
}

private extension RatingStackView {

  func setupStyle() {
    axis = .horizontal
    distribution = .fill
    spacing = 5
  }

  func setupLayout() {
    [firstStar, secondStar, thirdStar, fourthStar, fifthStar].forEach {
      addArrangedSubview($0)
    }
  }
}
