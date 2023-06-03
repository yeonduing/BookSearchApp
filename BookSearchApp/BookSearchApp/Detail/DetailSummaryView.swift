//
//  DetailSummaryView.swift
//  BookSearchApp
//
//  Created by itzel.du on 2023/06/01.
//

import UIKit

final class DetailSummaryView: UIView {

  private let infoLabel: DetailInfoLabel = .init(font: .detailETCLarge)
  private let titleLabel: DetailInfoLabel = .init(font: .detailETC)

  init() {
    super.init(frame: .zero)

    setupStyle()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(with info: String, title: String) {
    infoLabel.text = info
    titleLabel.text = title
  }
}

private extension DetailSummaryView {

  func setupStyle() {
    infoLabel.textAlignment = .center
    infoLabel.textColor = .detailBackground

    titleLabel.textAlignment = .center
    titleLabel.textColor = .detailBackground
  }

  func setupConstraints() {
    [infoLabel, titleLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }

    NSLayoutConstraint.activate([
      infoLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
      infoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

      titleLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 3),
      titleLabel.centerXAnchor.constraint(equalTo: infoLabel.centerXAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: infoLabel.leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: infoLabel.trailingAnchor),
      titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
    ])
  }
}
