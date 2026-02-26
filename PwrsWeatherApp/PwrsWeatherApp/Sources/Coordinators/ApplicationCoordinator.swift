//
//  ApplicationCoordinator.swift
//  PwrsWeatherApp
//
//  Created by Aysen Eremeev on 25.02.2026.
//

import UIKit

final class ApplicationCoordinator: BaseCoordinator {

    private var router: RouterProtocol

    init(router: RouterProtocol) {
        self.router = router
    }

    override func start() {
        runMainFlow()
    }

    private func runMainFlow() {
        let rootViewController = UINavigationController()
        let router = Router(rootController: rootViewController)
        self.router = router
        SceneDelegate.shared?.window?.set(rootViewController: rootViewController)
        removeAllDependency()
        let mainCoordinator = MainCoordinator(router: router)
        mainCoordinator.start()
    }
}
