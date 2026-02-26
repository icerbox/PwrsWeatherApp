//
//  RouterProtocol.swift
//  PwrsWeatherApp
//
//  Created by Aysen Eremeev on 25.02.2026.
//

import UIKit

protocol RouterProtocol: AnyObject {

    /// Present module
    func present(_ controller: UIViewController)
    func present(_ controller: UIViewController, animated: Bool, completion: (() ->Void)?)

    /// Dismiss module
    func dismissModule()
    func dismissModule(animated: Bool, completion: (() -> Void)?)

    /// Push module
    func push(_ controller: UIViewController)
    func push(_ controller: UIViewController, animated: Bool, completion: (() -> Void)?)

    /// Pop module
    func popModule()
}

final class Router: NSObject, RouterProtocol {

    private weak var rootController: UINavigationController?

    init(rootController: UINavigationController) {
        self.rootController = rootController
    }

    // MARK: - Present module
    func present(_ controller: UIViewController) {
        present(controller, animated: true, completion: nil)
    }

    func present(_ controller: UIViewController, animated: Bool, completion: (() ->Void)?) {
        rootController?.present(controller, animated: animated, completion: completion)
    }

    // MARK: - Dismiss module
    func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }

    func dismissModule(animated: Bool, completion: (() -> Void)?) {
        rootController?.dismiss(animated: animated, completion: completion)
    }

    // MARK: - Push module
    func push(_ controller: UIViewController) {
        push(controller, animated: true, completion: nil)
    }

    func push(_ controller: UIViewController, animated: Bool, completion: (() -> Void)?) {
        guard controller is UINavigationController == false else {
            assertionFailure("Deprecated push UINavigationController")
            return
        }

        if let completion = completion, let window = SceneDelegate.shared?.window {
            UIView.transition(
                with: window,
                duration: 0.3,
                animations: { [weak self] in
                    self?.rootController?.pushViewController(controller, animated: animated)
                },
                completion: { isFinished in
                    if isFinished {
                        completion()
                    }
                }
            )
        } else {
            rootController?.pushViewController(controller, animated: animated)
        }
    }

    // MARK: - Pop module
    func popModule() {
        popModule(animated: true)
    }

    func popModule(animated: Bool) {
        rootController?.popViewController(animated: animated)
    }
}
