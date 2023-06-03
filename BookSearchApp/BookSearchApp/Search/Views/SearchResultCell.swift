//
//  SearchResultCell.swift
//  BookSearchApp
//
//  Created by itzel.du on 2023/05/31.
//

import UIKit
import Combine

final class SearchResultCell: UICollectionViewCell {

  private let imageView: UIImageView = .init()
  private let titleLabel: UILabel = .init()
  private let subtitleLabel: UILabel = .init()
  private let priceLabel: UILabel = .init()
  private let isbn13Label: UILabel = .init()
  private let urlLabel: UILabel = .init()
  private let indicator: UIActivityIndicatorView = .init(style: .medium)

  private var imageLoader: ImageLoader?

  private var imageLoadCancellable: AnyCancellable?

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupStyle()
    setupLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(with book: Book, imageCache: ImageCacheable, network: NetworkService) {
    imageLoader = .init(imageCache: imageCache, network: network)

    bindImageLoader()

    indicator.startAnimating()

    titleLabel.text = book.title
    subtitleLabel.text = book.subtitle
    priceLabel.text = book.price
    isbn13Label.text = book.isbn13
    urlLabel.text = book.urlString
    updateImage(with: book.imageURLString)
  }
}

private extension SearchResultCell {

  func setupStyle() {
    layer.backgroundColor = UIColor.cellBackground?.cgColor
    layer.cornerRadius = 10
    layer.frame = frame
    layer.shadowOffset = CGSize(width: 5, height: 10)
    layer.shadowRadius = 20
    layer.shadowOpacity = 1
    layer.shadowColor = UIColor.shadow?.cgColor

    imageView.contentMode = .scaleAspectFill

    titleLabel.font = .thumbnailTitle
    titleLabel.numberOfLines = 3
    titleLabel.adjustsFontSizeToFitWidth = true
    titleLabel.lineBreakMode = .byTruncatingTail
    titleLabel.textColor = .primary

    subtitleLabel.font = .thumbnailSubtitle
    subtitleLabel.textColor = .secondary

    priceLabel.font = .thumbnailPrice
    priceLabel.textColor = .main
    priceLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)

    isbn13Label.font = .thumbnailIsbn13
    isbn13Label.textColor = .tertiary
    isbn13Label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

    urlLabel.font = .thumbnailURL
    urlLabel.textColor = .tertiary
    urlLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

    indicator.startAnimating()
  }

  func setupLayout() {
    [imageView, titleLabel, subtitleLabel, priceLabel, isbn13Label, urlLabel, indicator].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
    }

    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      imageView.widthAnchor.constraint(equalToConstant: 110),

      titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

      subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
      subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

      priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),

      isbn13Label.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      isbn13Label.topAnchor.constraint(equalTo: priceLabel.topAnchor),
      isbn13Label.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: -5),

      urlLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      urlLabel.trailingAnchor.constraint(equalTo: isbn13Label.trailingAnchor),
      urlLabel.lastBaselineAnchor.constraint(equalTo: priceLabel.lastBaselineAnchor),

      indicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
      indicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
    ])
  }

  func bindImageLoader() {
    imageLoadCancellable = imageLoader?
      .imagePublisher
      .receive(on: DispatchQueue.main)
      .sink { [weak imageView, weak indicator] in
        imageView?.image = $0
        indicator?.stopAnimating()
      }
  }

  func updateImage(with imageURLString: String) {
    imageLoader?.fetch(urlString: imageURLString)
  }
}
