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

        let currentWeather: CurrentWeatherViewModel = getCurrentWeather(model: response)
        let hourlyForecast: [HourlyForecastItem]? = getHourlyForecast(model: response.hourlyForecast)
        let dailyForecast: [DailyForecastItem]? = getDailyForecast(model: response.forecastDays)
        let hasForecast: Bool = getHasForecastStatus(hourlyForecast: response.hourlyForecast, dailyForecast: response.forecastDays)

        return MainViewModel(
            currentWeather: currentWeather,
            hourlyForecast: hourlyForecast,
            dailyForecast: dailyForecast,
            hasForecast: hasForecast
        )
    }

    private func getCurrentWeather(model: MainModel) -> CurrentWeatherViewModel {
        CurrentWeatherViewModel(
            locationName: model.locationName,
            temperature: "\(Int(model.temperature))",
            condition: getWeatherConditionLocalizedString(weatherCondition: model.weatherCondition),
            highLow: "H:\(Int(model.temperature + 2))° L:\(Int(model.temperature - 3))°",
            feelsLike: model.feelsLike,
            humidity: "\(model.humidity)%",
            windSpeed: String(format: "%.0f", model.windSpeed),
            uvIndex: getUvValueString(uvIndex: model.uvIndex),
            iconURL: model.conditionIconURL
        )
    }

    private func getWeatherConditionLocalizedString(weatherCondition: WeatherCondition) -> String {
        weatherCondition.localizedTitle
    }

    private func getUvValueString(uvIndex: Double) -> String {
        let uvValue = Int(uvIndex)
        switch uvValue {
        case 0...2: 
            return "Низкий"
        case 3...5:
            return "Средний"
        case 6...7:
            return"Высокий"
        case 8...10:
            return "Очень высокий"
        default:
            return "Экстремальный"
        }
    }

    private func getHourlyForecast(model: [HourForecastModel]?) -> [HourlyForecastItem]? {
        guard let hourlyForecast = model else { return nil }
        return hourlyForecast.map { hour in
            HourlyForecastItem(
                time: hour.time,
                temperature: Int(hour.temperature),
                iconName: getIconName(for: hour.condition),
                precipitation: hour.chanceOfRain
            )
        }
    }

    private func getDailyForecast(model: [ForecastDayModel]?) -> [DailyForecastItem]? {
        guard let forecastDays = model else { return nil }
        return forecastDays.map { day in
            DailyForecastItem(
                day: String(day.dayOfWeek.prefix(3)),
                iconName: getIconName(for: day.condition),
                precipitation: day.chanceOfRain,
                lowTemp: Int(day.minTemp),
                highTemp: Int(day.maxTemp)
            )
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

    private func getHasForecastStatus(hourlyForecast: [HourForecastModel]?, dailyForecast: [ForecastDayModel]?) -> Bool {
        guard let hourly = hourlyForecast, let daily = dailyForecast else { return false }
        return !hourly.isEmpty && !daily.isEmpty
    }
}
