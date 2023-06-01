//
//  SearchController.swift
//  BookSearchApp
//
//  Created by itzel.du on 2023/05/31.
//

import UIKit

final class SearchController: UISearchController {

  override func viewDidLoad() {
    super.viewDidLoad()

    setupStyle()
  }
}

private extension SearchController {

  func setupStyle() {
    obscuresBackgroundDuringPresentation = false
    searchBar.placeholder = "검색할 내용을 입력해주세요."
    searchBar.tintColor = .secondary
    searchBar.returnKeyType = .done
  }
}

