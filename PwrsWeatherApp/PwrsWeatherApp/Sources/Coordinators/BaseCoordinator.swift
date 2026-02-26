//
//  BaseCoordinator.swift
//  PwrsWeatherApp
//
//  Created by Aysen Eremeev on 25.02.2026.
//

import Foundation

protocol CoordinatorProtocol: AnyObject {
    func start()
}

class BaseCoordinator: CoordinatorProtocol {

    var childCoordinators: [CoordinatorProtocol] = []

    func start() {}

    func addDependency(_ coordinator: CoordinatorProtocol) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        childCoordinators.append(coordinator)
    }

    func removeDependency(_ coordinator: CoordinatorProtocol?) {
        guard !childCoordinators.isEmpty, let coordinator = coordinator else { return }

        if let coordinator = coordinator as? BaseCoordinator, !coordinator.childCoordinators.isEmpty {
            coordinator.childCoordinators
                .filter { $0 !== coordinator }
                .forEach { coordinator.removeDependency($0) }
        }
        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }

    func removeAllDependency() {
        childCoordinators.removeAll()
    }
}
