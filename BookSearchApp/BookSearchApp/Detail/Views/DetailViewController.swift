//
//  DetailViewController.swift
//  BookSearchApp
//
//  Created by itzel.du on 2023/06/01.
//

import UIKit
import Combine

final class DetailViewController: UIViewController {

  private let imageView: UIImageView = .init()
  private let scrollView: UIScrollView = .init()
  private let detailInfoStackView: DetailInfoStackView = .init()
  private let blurView: DetailBlurView = .init(effect: nil)

  private let dummyView: UIView = .init()

  private let bookmarkButton: DetailOptionButton = .init(option: .bookmark)
  private let pdfButton: DetailOptionButton = .init(option: .pdf)
  private let urlButton: DetailOptionButton = .init(option: .url)

  private let backButton: UIButton = .init()

  private let backgroundGradientLayer: CAGradientLayer = .init()

  private let viewModel: DetailViewModel
  private let imageLoader: ImageLoader
  private var cancellables: Set<AnyCancellable> = .init()

  private let imageHeight = UIScreen.main.bounds.height / 3
  private var isOptionButtonHidden = false

  init(viewModel: DetailViewModel, imageLoader: ImageLoader) {
    self.viewModel = viewModel
    self.imageLoader = imageLoader

    super.init(nibName: nil, bundle: nil)

    setupStyle()
    setupLayout()
    setupButtonAction()
    bindViewModel()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    setupNavigationBar()
    blurView.startIndicator()
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    backgroundGradientLayer.colors = [
      UIColor.leftGradient?.cgColor ?? UIColor.clear.cgColor,
      UIColor.rightGradient?.cgColor ?? UIColor.clear.cgColor
    ]
  }
}

private extension DetailViewController {

  func setupStyle() {
    imageView.contentMode = .scaleAspectFit

    backgroundGradientLayer.frame = view.bounds
    backgroundGradientLayer.startPoint = CGPoint(x: 0.1, y: 0.5)
    backgroundGradientLayer.endPoint = CGPoint(x: 0.45, y: -0.1)
    view.layer.addSublayer(backgroundGradientLayer)

    dummyView.backgroundColor = .detailBackground

    scrollView.contentInset = UIEdgeInsets(top: imageHeight + 60, left: 0, bottom: -500, right: 0)
    scrollView.alwaysBounceVertical = true
    scrollView.showsVerticalScrollIndicator = false
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.delegate = self

    bookmarkButton.isEnabled = false
    pdfButton.isEnabled = false
  }

  func setupLayout() {
    [imageView, scrollView, bookmarkButton, pdfButton, urlButton, blurView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }

    [detailInfoStackView, dummyView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      scrollView.addSubview($0)
    }

    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -24),
      imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      imageView.heightAnchor.constraint(equalToConstant: imageHeight),

      scrollView.topAnchor.constraint(equalTo: view.topAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

      bookmarkButton.topAnchor.constraint(equalTo: imageView.bottomAnchor),
      bookmarkButton.widthAnchor.constraint(equalToConstant: 44),
      bookmarkButton.heightAnchor.constraint(equalTo: bookmarkButton.widthAnchor),
      bookmarkButton.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: -90),

      pdfButton.topAnchor.constraint(equalTo: bookmarkButton.topAnchor),
      pdfButton.widthAnchor.constraint(equalToConstant: 44),
      pdfButton.heightAnchor.constraint(equalTo: pdfButton.widthAnchor),
      pdfButton.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),

      urlButton.topAnchor.constraint(equalTo: bookmarkButton.topAnchor),
      urlButton.widthAnchor.constraint(equalToConstant: 44),
      urlButton.heightAnchor.constraint(equalTo: urlButton.widthAnchor),
      urlButton.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 90),

      blurView.topAnchor.constraint(equalTo: view.topAnchor),
      blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])

    NSLayoutConstraint.activate([
      detailInfoStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      detailInfoStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      detailInfoStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      detailInfoStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

      dummyView.topAnchor.constraint(equalTo: detailInfoStackView.bottomAnchor),
      dummyView.leadingAnchor.constraint(equalTo: detailInfoStackView.leadingAnchor),
      dummyView.trailingAnchor.constraint(equalTo: detailInfoStackView.trailingAnchor),
      dummyView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      dummyView.heightAnchor.constraint(equalToConstant: 500)
    ])
  }

  func setupNavigationBar() {
    let navigationBar = navigationController?.navigationBar
    navigationBar?.prefersLargeTitles = false
    navigationBar?.backgroundColor = .clear
    navigationBar?.setBackgroundImage(UIImage(), for: .default)
    navigationBar?.shadowImage = UIImage()
    navigationBar?.isTranslucent = true
    navigationBar?.tintColor = .primary

    tabBarController?.tabBar.isHidden = true

    backButton.setImage(.chevronLeft, for: .normal)

    let backButtonItem = UIBarButtonItem(customView: backButton)
    navigationItem.leftBarButtonItem = backButtonItem
  }

  func setupButtonAction() {
    pdfButton.addAction(
      .init(handler: { [weak viewModel] _ in
        guard
          let urlString = viewModel?.pdfURLString,
          let url = URL(string: urlString),
          UIApplication.shared.canOpenURL(url)
        else { return }

        UIApplication.shared.open(url)
      }), for: .touchUpInside
    )

    urlButton.addAction(
      .init(handler: { [weak viewModel] _ in
        guard
          let urlString = viewModel?.urlString,
          let url = URL(string: urlString),
          UIApplication.shared.canOpenURL(url)
        else { return }

        UIApplication.shared.open(url)
      }), for: .touchUpInside
    )

    backButton.addAction(
      .init(handler: { [weak self] _ in
        self?.navigationController?.popViewController(animated: true)
      }), for: .touchUpInside
    )
  }

  func bindViewModel() {
    viewModel.detailBookPublisher
      .subscribe(on: DispatchQueue.global())
      .receive(on: DispatchQueue.main)
      .compactMap { $0 }
      .sink { [weak self] bookDetail in
        self?.detailInfoStackView.configure(with: bookDetail)
        self?.fetchImage(with: bookDetail.imageURLString)
        self?.bindLoadingImage()

        self?.pdfButton.isEnabled = bookDetail.pdf?.values.first != nil
      }
      .store(in: &cancellables)
  }

  func bindLoadingImage() {
    imageLoader.imagePublisher
      .subscribe(on: DispatchQueue.global())
      .receive(on: DispatchQueue.main)
      .sink { [weak imageView, weak blurView] image in
        imageView?.image = image
        blurView?.stopIndicator()
      }
      .store(in: &cancellables)
  }

  func fetchImage(with urlString: String) {
    imageLoader.fetch(urlString: urlString)
  }
}

extension DetailViewController: UIScrollViewDelegate {

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    scrollView.contentOffset.y > -(imageHeight + 60 + 50) ? optionButtonFadeInAnimation() : optionButtonFadeOutAnimation()
  }
}

private extension DetailViewController {

  func optionButtonFadeInAnimation() {
    guard isOptionButtonHidden else { return }

    bookmarkButton.alpha = 0
    pdfButton.alpha = 0
    urlButton.alpha = 0

    isOptionButtonHidden = false
  }

  func optionButtonFadeOutAnimation() {
    guard !isOptionButtonHidden else { return }

    bookmarkButton.alpha = 1
    pdfButton.alpha = 1
    urlButton.alpha = 1

    isOptionButtonHidden = true
  }
}
