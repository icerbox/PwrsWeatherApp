//
//  MainProvider.swift
//  PwrsWeatherApp
//
//  Created by Aysen Eremeev on 25.02.2026.
//

protocol MainProviderProtocol {

    /// Получение текущего прогноза погоды
    func fetchCurrentWeather(completion: @escaping (RequestResult<WeatherResponse>) -> Void)

    /// Получение прогноза погоды на несколько дней
    func fetchWeatherForecast(completion: @escaping (RequestResult<WeatherResponse>) -> Void)
}

struct MainProvider: MainProviderProtocol {

    private let service: MainServiceProtocol

    init(service: MainServiceProtocol = MainService()) {
        self.service = service
    }

    func fetchCurrentWeather(completion: @escaping (RequestResult<WeatherResponse>) -> Void) {
        service.fetchCurrentWeather(completion: completion)
    }

    func fetchWeatherForecast(completion: @escaping (RequestResult<WeatherResponse>) -> Void) {
        service.fetchWeatherForecast(completion: completion)
    }
}
