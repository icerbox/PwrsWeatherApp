//
//  MainBuilder.swift
//  PwrsWeatherApp
//
//  Created by Aysen Eremeev on 25.02.2026.
//

import UIKit

final class MainBuilder {

    func build() -> UIViewController {
        let presenter = MainPresenter()
        let interactor = MainInteractor(presenter: presenter)
        let view = MainViewController(interactor: interactor)

        presenter.viewController = view

        return view
    }
}
