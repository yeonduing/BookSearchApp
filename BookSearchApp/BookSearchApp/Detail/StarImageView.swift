//
//  StarImageView.swift
//  BookSearchApp
//
//  Created by itzel.du on 2023/06/01.
//

import UIKit

final class StarImageView: UIImageView {

  init() {
    super.init(frame: .zero)

    setupStyle()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupStyle()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func fillStar() {
    image = .starFill
  }
}

private extension StarImageView {

  func setupStyle() {
    image = .star
    backgroundColor = .clear
    contentMode = .scaleAspectFit
    sizeToFit()

    layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
    layer.shadowRadius = 3
    layer.shadowOffset = CGSize(width: 3, height: 5)
    layer.shadowOpacity = 1
  }
}

