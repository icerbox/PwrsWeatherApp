//
//  MainProvider.swift
//  PwrsWeatherApp
//
//  Created by Aysen Eremeev on 25.02.2026.
//

protocol MainProviderProtocol {

    /// Получение прогноза погоды на несколько дней
    func fetchWeatherForecast(latitude: String, longitude: String, completion: @escaping (RequestResult<WeatherResponse>) -> Void)
}

struct MainProvider: MainProviderProtocol {

    private let service: MainServiceProtocol

    init(service: MainServiceProtocol = MainService()) {
        self.service = service
    }

    func fetchWeatherForecast(latitude: String, longitude: String, completion: @escaping (RequestResult<WeatherResponse>) -> Void) {
        service.fetchWeatherForecast(latitude: latitude, longitude: longitude, completion: completion)
    }
}
