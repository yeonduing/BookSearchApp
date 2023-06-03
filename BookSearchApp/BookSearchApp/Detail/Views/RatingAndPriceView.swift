//
//  RatingAndPriceView.swift
//  BookSearchApp
//
//  Created by itzel.du on 2023/06/01.
//

import UIKit

final class RatingAndPriceView: UIView {

  private let ratingView: RatingStackView = .init()
  private let priceLabel: UILabel = .init()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupStyle()
    setupLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(withRating rating: Int, price: String) {
    ratingView.configure(with: rating)
    priceLabel.text = price
  }
}

private extension RatingAndPriceView {

  func setupStyle() {
    priceLabel.font = .detailPrice
    priceLabel.textColor = .main
    priceLabel.textAlignment = .right

    ratingView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    priceLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
  }

  func setupLayout() {
    [ratingView, priceLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }

    NSLayoutConstraint.activate([
      ratingView.topAnchor.constraint(equalTo: topAnchor),
      ratingView.bottomAnchor.constraint(equalTo: bottomAnchor),
      ratingView.leadingAnchor.constraint(equalTo: leadingAnchor),

      priceLabel.topAnchor.constraint(equalTo: topAnchor),
      priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
      priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      priceLabel.leadingAnchor.constraint(equalTo: ratingView.trailingAnchor)
    ])
  }
}
