//
//  DetailInfoStackView.swift
//  BookSearchApp
//
//  Created by itzel.du on 2023/06/01.
//

import UIKit

final class DetailInfoStackView: UIStackView {

  private let titleLabel: DetailInfoLabel = .init(font: .detailTitle)
  private let subtitleLabel: DetailInfoLabel = .init(font: .detailSubtitle)
  private let authorLabel: DetailInfoLabel = .init(font: .detailAuthor)
  private let ratingAndPriceView: RatingAndPriceView = .init()
  private let publisherLabel: DetailInfoLabel = .init(font: .detailPublisher)
  private let detailSummaryStackView: DetailSummaryStackView = .init()
  private let descriptionLabel: DetailInfoLabel = .init(font: .detailDescription)
  private let isbnView: ISBNView = .init()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupStyle()
    setupLayout()
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(with detail: BookDetail) {
    titleLabel.configure(with: detail.title)
    subtitleLabel.configure(with: detail.subtitle)
    authorLabel.configure(with: detail.authors)
    ratingAndPriceView.configure(withRating: detail.rating, price: detail.price)
    publisherLabel.configure(with: detail.publisher)
    detailSummaryStackView.configure(with: BookSummary(rating: "\(detail.rating)", pages: detail.pages, year: detail.year))
    descriptionLabel.configure(with: detail.descriptionString)
    isbnView.configure(withISBN10: detail.isbn10, isbn13: detail.isbn13)
  }
}

private extension DetailInfoStackView {

  func setupStyle() {
    axis = .vertical
    distribution = .fill
    spacing = 20
    layer.cornerRadius = 15
    layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    backgroundColor = .detailBackground

    layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    isLayoutMarginsRelativeArrangement = true
  }

  func setupLayout() {
    [titleLabel, subtitleLabel, authorLabel, ratingAndPriceView, publisherLabel, detailSummaryStackView, descriptionLabel, isbnView].forEach {
      addArrangedSubview($0)
    }
  }
}
