//
//  DetailSummaryStackView.swift
//  BookSearchApp
//
//  Created by itzel.du on 2023/06/01.
//

import UIKit

final class DetailSummaryStackView: UIStackView {

  private let ratingInfoView: DetailSummaryView = .init()
  private let pagesInfoView: DetailSummaryView = .init()
  private let yearInfoView: DetailSummaryView = .init()

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

  func configure(with bookSummary: BookSummary) {
    ratingInfoView.configure(with: "\(bookSummary.rating) / 5", title: "rating")
    pagesInfoView.configure(with: bookSummary.pages, title: "pages")
    yearInfoView.configure(with: bookSummary.year, title: "year")
  }
}

private extension DetailSummaryStackView {

  func setupStyle() {
    backgroundColor = .secondary

    layer.cornerRadius = 10
    layer.masksToBounds = true
    axis = .horizontal
    distribution = .fillEqually
    spacing = 0
  }

  func setupLayout() {
    [ratingInfoView, pagesInfoView, yearInfoView].forEach {
      addArrangedSubview($0)
    }
  }
}
