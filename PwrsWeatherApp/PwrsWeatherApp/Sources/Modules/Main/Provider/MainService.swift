//
//  MainService.swift
//  PwrsWeatherApp
//
//  Created by Aysen Eremeev on 25.02.2026.
//

protocol MainServiceProtocol {

    /// Получение текущего прогноза погоды
    func fetchCurrentWeather(completion: @escaping (RequestResult<WeatherResponse>) -> Void)

    /// Получение прогноза на несколько дней
    func fetchWeatherForecast(completion: @escaping (RequestResult<WeatherResponse>) -> Void)
}

final class MainService: MainServiceProtocol {

    private let networkService = NetworkService()

    //  Получение текущего прогноза погоды
    func fetchCurrentWeather(completion: @escaping (RequestResult<WeatherResponse>) -> Void) {
        let url = "https://api.weatherapi.com/v1/current.json?key=fa8b3df74d4042b9aa7135114252304&q=LAT,LON"
        networkService.get(url, model: WeatherResponse.self, completion: completion)
    }

    //  Получение прогноза погоды на несколько дней
    func fetchWeatherForecast(completion: @escaping (RequestResult<WeatherResponse>) -> Void) {
        let url = "https://api.weatherapi.com/v1/forecast.json?key=fa8b3df74d4042b9aa7135114252304&q=LAT,LON&days=3"
        networkService.get(url, model: WeatherResponse.self, completion: completion)
    }
}

