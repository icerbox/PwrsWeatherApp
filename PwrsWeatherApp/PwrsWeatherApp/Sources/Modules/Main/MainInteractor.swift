//
//  MainInteractor.swift
//  PwrsWeatherApp
//
//  Created by Aysen Eremeev on 25.02.2026.
//

import CoreLocation

protocol MainBusinessLogic {

    /// Запрос на получение прогноза погоды
    func getForecast(request: Main.GetForecast.Request)
}

final class MainInteractor: MainBusinessLogic {

    private let presenter: MainPresentationLogic
    private let provider: MainProviderProtocol
    private var locationService: LocationServiceProtocol

    init(
        presenter: MainPresentationLogic,
        provider: MainProviderProtocol = MainProvider(),
        locationService: LocationServiceProtocol = LocationService()
    ) {
        self.presenter = presenter
        self.provider = provider
        self.locationService = locationService
        self.locationService.locationServiceDelegate = self
    }

    // Запрос на получение прогноза погоды
    func getForecast(request: Main.GetForecast.Request) {
        locationService.requestLocationPermission()
    }

    private func fetchWeather(latitude: String, longitude: String) {

        self.provider.fetchWeatherForecast(latitude: latitude, longitude: longitude) { [weak self] result in
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

extension MainInteractor: LocationServiceDelegate {

    func didUpdateLocations(_ locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let latitude = "\(location.coordinate.latitude)"
        let longitude = "\(location.coordinate.longitude)"
        fetchWeather(latitude: latitude, longitude: longitude)
    }

    func didFailWithError(_ error: Error) {
        let response = Main.Error.Response(message: "Не удалось получить местоположение: \(error.localizedDescription)")
        presenter.presentError(response: response)
    }

    func locationPermissionDenied() {
        // Если нет доступа показываем прогноз погоды для Москвы
        let latitude = "55.75222,"
        let longitude = "37.61556"
        fetchWeather(latitude: latitude, longitude: longitude)
    }
}
