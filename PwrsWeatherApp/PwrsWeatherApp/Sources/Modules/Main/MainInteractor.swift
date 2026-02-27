//
//  MainInteractor.swift
//  PwrsWeatherApp
//
//  Created by Aysen Eremeev on 25.02.2026.
//

import Foundation

protocol MainBusinessLogic {

    /// Запрос на получение прогноза погоды
    func getForecast(request: Main.GetForecast.Request)
}

final class MainInteractor: MainBusinessLogic {

    private let presenter: MainPresentationLogic
    private let provider: MainProviderProtocol

    init(presenter: MainPresentationLogic, provider: MainProviderProtocol = MainProvider()) {
        self.presenter = presenter
        self.provider = provider
    }

    // Запрос на получение прогноза погоды
    func getForecast(request: Main.GetForecast.Request) {
        self.provider.fetchWeatherForecast { [weak self] result in
            switch result {
            case let .success(model):
                let response = Main.GetForecast.Response(response: model)
                self?.presenter.presentForecast(response: response)
            case let .failure(errorMessage):
                let response = Main.Error.Response(message: errorMessage)
                self?.presenter.presentError(response: response)
            }
        }
    }
}
