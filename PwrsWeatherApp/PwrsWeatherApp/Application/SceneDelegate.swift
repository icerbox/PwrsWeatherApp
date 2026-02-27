//
//  SceneDelegate.swift
//  PwrsWeatherApp
//
//  Created by Aysen Eremeev on 25.02.2026.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Shared
    static let shared: SceneDelegate? = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate

    var window: UIWindow?
    var appCoordinator: ApplicationCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let rootController = UINavigationController()

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()

        appCoordinator = ApplicationCoordinator(router: Router(rootController: rootController))
        appCoordinator?.start()
    }
}

