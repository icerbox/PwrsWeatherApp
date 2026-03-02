//
//  MainViewModel.swift
//  PwrsWeatherApp
//
//  Created by Aysen Eremeev on 25.02.2026.
//

import Foundation

enum MainState {
    case loading
    case error(message: String)
    case result(MainViewModel)
}

enum MainSection: Int, CaseIterable {
    case current
    case hourly
    case daily
}

struct MainViewModel {
    let currentWeather: CurrentWeatherViewModel
    let hourlyForecast: [HourlyForecastItem]?
    let dailyForecast: [DailyForecastItem]?
    let hasForecast: Bool
}

struct CurrentWeatherViewModel {
    let locationName: String
    let temperature: String
    let condition: String
    let highLow: String
    let feelsLike: Double
    let humidity: String
    let windSpeed: String
    let uvIndex: String
    let iconURL: URL?
}

struct HourlyForecastItem {
    let time: String
    let temperature: Int
    let iconName: String
    let precipitation: Int
}

struct DailyForecastItem {
    let day: String
    let iconName: String
    let precipitation: Int
    let lowTemp: Int
    let highTemp: Int
}
