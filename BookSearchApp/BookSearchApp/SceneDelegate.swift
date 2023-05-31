//
//  SceneDelegate.swift
//  BookSearchApp
//
//  Created by itzel.du on 2023/05/30.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = (scene as? UIWindowScene) else { return }

    let viewController: SearchViewController = .init(viewModel: .init(repository: SearchRepository()))
    let navigationViewController: UINavigationController = .init(rootViewController: viewController)

    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = navigationViewController
    window?.makeKeyAndVisible()
  }
}

