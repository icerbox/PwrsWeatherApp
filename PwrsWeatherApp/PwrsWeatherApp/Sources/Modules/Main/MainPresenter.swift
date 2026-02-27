//
//  MainPresenter.swift
//  PwrsWeatherApp
//
//  Created by Aysen Eremeev on 25.02.2026.
//

import UIKit

protocol MainPresentationLogic {

    /// Показ результатов прогноза погоды
    func presentForecast(response: Main.GetForecast.Response)

    /// Показ ошибки
    func presentError(response: Main.Error.Response)
}

final class MainPresenter: MainPresentationLogic {

    weak var viewController: MainDisplayLogic?

    // Показ результатов прогноза погоды
    func presentForecast(response: Main.GetForecast.Response) {
        let model = MainModel(from: response.response)
        let viewModel = getViewModel(from: model)
        viewController?.displayResult(state: .result(viewModel))
    }

    // Показ ошибки
    func presentError(response: Main.Error.Response) {
        viewController?.displayResult(state: .error(message: response.message))
    }
}

extension MainPresenter {

    private func getViewModel(from response: MainModel) -> MainViewModel {
        return MainViewModel(from: response)
    }
}
