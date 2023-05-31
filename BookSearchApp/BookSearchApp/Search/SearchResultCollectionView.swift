//
//  SearchResultCollectionView.swift
//  BookSearchApp
//
//  Created by itzel.du on 2023/05/31.
//

import UIKit

final class SearchResultCollectionView: UICollectionView {

  init() {
    super.init(frame: .zero, collectionViewLayout: .init())

    setupStyle()
    setupFlowLayout()
    registerView()
  }

  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)

    setupStyle()
    setupFlowLayout()
    registerView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension SearchResultCollectionView {

  func setupStyle() {
    backgroundColor = .clear
    showsHorizontalScrollIndicator = false
    alwaysBounceVertical = true
  }

  func setupFlowLayout() {
    let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
    let baseInset: CGFloat = 15

    flowLayout?.itemSize = CGSize(width: UIScreen.main.bounds.width - 30, height: 170)
    flowLayout?.minimumLineSpacing = 26
    flowLayout?.minimumInteritemSpacing = 10
    flowLayout?.sectionInset = UIEdgeInsets(
      top: baseInset,
      left: baseInset,
      bottom: baseInset,
      right: baseInset
    )
  }

  func registerView() {
    registerCell(ofType: SearchResultCell.self)
  }
}
