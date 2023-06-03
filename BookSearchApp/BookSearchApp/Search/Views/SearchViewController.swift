//
//  SearchViewController.swift
//  BookSearchApp
//
//  Created by itzel.du on 2023/05/30.
//

import UIKit
import Combine

final class SearchViewController: UIViewController {

  private let viewModel: SearchViewModel

  private let collectionView: SearchResultCollectionView = .init()
  private let searchController: SearchController = .init(searchResultsController: nil)

  private var cancellables: Set<AnyCancellable> = .init()

  init(viewModel: SearchViewModel) {
    self.viewModel = viewModel

    super.init(nibName: nil, bundle: nil)

    setupStyle()
    setupLayout()
    bindViewModel()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.backgroundColor = .searchBackground
    navigationController?.navigationBar.sizeToFit()
  }
}

private extension SearchViewController {

  func setupStyle() {
    title = "Search"
    view.backgroundColor = .searchBackground

    navigationItem.searchController = searchController
    definesPresentationContext = true

    searchController.searchBar.delegate = self

    collectionView.delegate = self
    collectionView.dataSource = self
  }

  func setupLayout() {
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(collectionView)

    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }

  func bindViewModel() {
    viewModel.booksPublisher
      .removeDuplicates()
      .receive(on: DispatchQueue.main)
      .sink { [weak collectionView] _ in
        collectionView?.reloadData()
      }
      .store(in: &cancellables)
  }
}

extension SearchViewController: UISearchBarDelegate {

  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    viewModel.fetchBooks(using: searchText)
  }

  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    viewModel.removeBooks()
  }
}

extension SearchViewController: UICollectionViewDelegate {

  func collectionView(
    _ collectionView: UICollectionView,
    willDisplay cell: UICollectionViewCell,
    forItemAt indexPath: IndexPath
  ) {
    guard indexPath.row == viewModel.bookCount - 1
    else { return }

    viewModel.fetchBooks()
  }

  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    let detailRepository: DetailRepository = .init()
    let detailViewModel: DetailViewModel = .init(isbn13: viewModel.books[indexPath.row].isbn13, repository: detailRepository)
    let imageLoader: ImageLoader = .init(imageCache: viewModel.imageDiskCache, network: viewModel.network)
    let detailViewController: DetailViewController = .init(viewModel: detailViewModel, imageLoader: imageLoader)

    navigationController?.show(detailViewController, sender: nil)
  }
}

extension SearchViewController: UICollectionViewDataSource {

  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell: SearchResultCell = collectionView.dequeueReusableCell(for: indexPath)
    cell.configure(with: viewModel.books[indexPath.row], imageCache: viewModel.imageMemoryCache, network: viewModel.network)

    return cell
  }

  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    viewModel.bookCount
  }
}
