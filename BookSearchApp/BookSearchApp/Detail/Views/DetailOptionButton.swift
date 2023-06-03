//
//  DetailOptionButton.swift
//  BookSearchApp
//
//  Created by itzel.du on 2023/06/01.
//

import UIKit

struct DetailOption {

  let image: UIImage?
  let hilightedImage: UIImage?
  let selectedImage: UIImage?
  let disabledImage: UIImage?
}

extension DetailOption {

  static var bookmark: Self {
    .init(image: .bookmark, hilightedImage: nil, selectedImage: .bookmarkFill, disabledImage: nil)
  }

  static var pdf: Self {
    .init(image: .pdf, hilightedImage: nil, selectedImage: nil, disabledImage: .pdfDisable)
  }

  static var url: Self {
    .init(image: .urlFill, hilightedImage: .url, selectedImage: nil, disabledImage: nil)
  }
}

final class DetailOptionButton: UIButton {

  init(option: DetailOption) {
    super.init(frame: .zero)

    setupImage(with: option)
    setupStyle()
  }

  init(frame: CGRect, option: DetailOption) {
    super.init(frame: frame)

    setupImage(with: option)
    setupStyle()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension DetailOptionButton {

  func setupImage(with option: DetailOption) {
    setImage(option.image, for: .normal)
    setImage(option.hilightedImage, for: .highlighted)
    setImage(option.selectedImage, for: .selected)
    setImage(option.disabledImage, for: .disabled)
  }

  func setupStyle() {
    layer.cornerRadius = 22
    backgroundColor = .detailOptionButton
    tintColor = .detailOptionButtonTint
  }
}
