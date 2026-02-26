//
//  MainCoordinator.swift
//  PwrsWeatherApp
//
//  Created by Aysen Eremeev on 25.02.2026.
//

import UIKit

final class MainCoordinator: BaseCoordinator {

    private let router: Router

    init(router: Router) {
        self.router = router
    }

    override func start() {
        openMain()
    }

    private func openMain() {
        let view = MainBuilder().build()

        router.push(view)
    }
}
