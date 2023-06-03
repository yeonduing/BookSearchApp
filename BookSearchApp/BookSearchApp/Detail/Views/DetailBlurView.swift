//
//  DetailBlurView.swift
//  BookSearchApp
//
//  Created by itzel.du on 2023/06/01.
//

import UIKit

final class DetailBlurView: UIVisualEffectView {

  private let indicator = UIActivityIndicatorView(style: .large)

  override init(effect: UIVisualEffect?) {
    super.init(effect: effect)

    setupStyle()
    setupLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func stopIndicator() {
    indicator.stopAnimating()

    UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: []) { [weak self] in
      self?.alpha = 0
    }
  }

  func startIndicator() {
    indicator.startAnimating()

    UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: []) { [weak self] in
      self?.alpha = 1
    }
  }
}

private extension DetailBlurView {

  func setupStyle() {
    let blurEffect = UIBlurEffect(style: .regular)
    effect = blurEffect
  }

  func setupLayout() {
    [indicator].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
    }

    NSLayoutConstraint.activate([
      indicator.centerXAnchor.constraint(equalTo: centerXAnchor),
      indicator.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }
}

