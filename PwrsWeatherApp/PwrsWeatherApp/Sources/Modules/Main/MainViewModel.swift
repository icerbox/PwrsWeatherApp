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

    init(from model: MainModel) {
        self.currentWeather = CurrentWeatherViewModel(
            locationName: model.locationName,
            temperature: model.temperature,
            condition: model.condition,
            highLow: "H:\(Int(model.temperature + 2))° L:\(Int(model.temperature - 3))°",
            feelsLike: model.feelsLike,
            humidity: model.humidity,
            windSpeed: model.windSpeed,
            uvIndex: model.uvIndex,
            iconURL: model.conditionIconURL
        )

        self.hourlyForecast = model.hourlyForecast?.map { hour in
            HourlyForecastItem(
                time: hour.time,
                temperature: Int(hour.temperature),
                iconName: getIconName(for: hour.condition),
                precipitation: hour.chanceOfRain
            )
        }

        self.dailyForecast = model.forecastDays?.map { day in
            DailyForecastItem(
                day: String(day.dayOfWeek.prefix(3)),
                iconName: getIconName(for: day.condition),
                precipitation: day.chanceOfRain,
                lowTemp: Int(day.minTemp),
                highTemp: Int(day.maxTemp)
            )
        }
    }
}

struct CurrentWeatherViewModel {
    let locationName: String
    let temperature: Double
    let condition: String
    let highLow: String
    let feelsLike: Double
    let humidity: Int
    let windSpeed: Double
    let uvIndex: Double
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

extension MainViewModel {

    var formattedTemperature: String {
        return "\(Int(currentWeather.temperature))°"
    }

    var formattedFeelsLike: String {
        return "\(Int(currentWeather.feelsLike))°"
    }

    var formattedHumidity: String {
        return "\(currentWeather.humidity)%"
    }

    var formattedWindSpeed: String {
        return String(format: "%.0f", currentWeather.windSpeed)
    }

    var formattedUVIndex: String {
        switch Int(currentWeather.uvIndex) {
        case 0...2: return "Низкий"
        case 3...5: return "Умеренный"
        case 6...7: return "Высокий"
        case 8...10: return "Очень высокий"
        default: return "Экстремальный"
        }
    }

    var weatherIconName: String {
        return getIconName(for: currentWeather.condition)
    }

    var hasForecast: Bool {
        guard let hourly = hourlyForecast, let daily = dailyForecast else { return false }
        return !hourly.isEmpty && !daily.isEmpty
    }
}

private func getIconName(for condition: String) -> String {
    let lowercased = condition.lowercased()

    if lowercased.contains("sunny") {
        return "sun.max.fill"
    } else if lowercased.contains("clear") {
        return "moon.stars.fill"
    } else if lowercased.contains("rain") && lowercased.contains("heavy") {
        return "cloud.heavyrain.fill"
    } else if lowercased.contains("rain") {
        return "cloud.rain.fill"
    } else if lowercased.contains("snow") {
        return "cloud.snow.fill"
    } else if lowercased.contains("thunder") {
        return "cloud.bolt.fill"
    } else if lowercased.contains("fog") {
        return "cloud.fog.fill"
    } else if lowercased.contains("cloudy") || lowercased.contains("cloud") {
        return "cloud.fill"
    } else {
        return "cloud.sun.fill"
    }
}
