//
//  MainService.swift
//  PwrsWeatherApp
//
//  Created by Aysen Eremeev on 25.02.2026.
//

protocol MainServiceProtocol {

    /// Получение прогноза на несколько дней
    func fetchWeatherForecast(latitude: String, longitude: String, completion: @escaping (RequestResult<WeatherResponse>) -> Void)
}

final class MainService: MainServiceProtocol {

    private let networkService = NetworkService()

    // Получение прогноза погоды на несколько дней
    func fetchWeatherForecast(latitude: String, longitude: String, completion: @escaping (RequestResult<WeatherResponse>) -> Void) {
        let url = "https://api.weatherapi.com/v1/forecast.json?key=fa8b3df74d4042b9aa7135114252304&q=\(latitude),\(longitude)&days=3"
        networkService.get(url, model: WeatherResponse.self, completion: completion)
    }
}

