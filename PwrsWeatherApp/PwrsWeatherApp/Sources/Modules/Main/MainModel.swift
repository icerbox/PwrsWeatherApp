//
//  MainModel.swift
//  PwrsWeatherApp
//
//  Created by Aysen Eremeev on 25.02.2026.
//

import Foundation

struct WeatherResponse: Decodable {
    let location: Location
    let current: CurrentWeather
    let forecast: Forecast?
}

struct Location: Codable {
    let name: String
    let localtime: String

    enum CodingKeys: String, CodingKey {
        case name
        case localtime
    }
}

struct Forecast: Decodable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Decodable {
    let date: String
    let day: DayWeather
    let hour: [HourWeather]
}

struct DayWeather: Decodable {
    let maxtempC: Double
    let mintempC: Double
    let condition: Condition
    let dailyChanceOfRain: Int

    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
        case condition
        case dailyChanceOfRain = "daily_chance_of_rain"
    }
}

struct HourWeather: Decodable {
    let time: String
    let tempC: Double
    let condition: Condition
    let chanceOfRain: Int

    enum CodingKeys: String, CodingKey {
        case time
        case tempC = "temp_c"
        case condition
        case chanceOfRain = "chance_of_rain"
    }
}

struct CurrentWeather: Decodable {
    let tempC: Double
    let condition: Condition
    let feelslikeC: Double
    let humidity: Int
    let windKph: Double
    let uv: Double

    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case condition
        case feelslikeC = "feelslike_c"
        case humidity
        case windKph = "wind_kph"
        case uv
    }
}

struct Condition: Decodable {
    let text: String
    let icon: String
    let code: WeatherCondition
}

struct MainModel {
    let locationName: String
    let localTime: String
    let temperature: Double
    let condition: String
    let weatherCondition: WeatherCondition
    let conditionIconURL: URL?
    let feelsLike: Double
    let humidity: Int
    let windSpeed: Double
    let uvIndex: Double

    let forecastDays: [ForecastDayModel]?
    let hourlyForecast: [HourForecastModel]?

    init(from response: WeatherResponse) {
        self.locationName = response.location.name
        self.localTime = response.location.localtime
        self.temperature = response.current.tempC
        self.condition = response.current.condition.text
        self.weatherCondition = response.current.condition.code
        self.conditionIconURL = URL(string: "https:\(response.current.condition.icon)")
        self.feelsLike = response.current.feelslikeC
        self.humidity = response.current.humidity
        self.windSpeed = response.current.windKph
        self.uvIndex = response.current.uv

        if let forecast = response.forecast {
            self.forecastDays = forecast.forecastday.map { ForecastDayModel(from: $0) }

            let now = Date()
            let calendar = Calendar.current
            let currentHour = calendar.component(.hour, from: now)

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let todayString = dateFormatter.string(from: now)

            var filteredHours: [HourForecastModel] = []

            for (index, day) in forecast.forecastday.enumerated() {
                let dayHours = day.hour.map { HourForecastModel(from: $0) }

                if index == 0 {
                    let remainingToday = dayHours.filter { $0.date == todayString && $0.hour >= currentHour }
                    filteredHours.append(contentsOf: remainingToday)
                } else if index == 1 {
                    filteredHours.append(contentsOf: dayHours)
                }
            }

            self.hourlyForecast = filteredHours
        } else {
            self.forecastDays = nil
            self.hourlyForecast = nil
        }
    }
}

struct ForecastDayModel {
    let date: String
    let dayOfWeek: String
    let maxTemp: Double
    let minTemp: Double
    let condition: String
    let conditionIconURL: URL?
    let chanceOfRain: Int

    init(from forecastDay: ForecastDay) {
        self.date = forecastDay.date
        self.maxTemp = forecastDay.day.maxtempC
        self.minTemp = forecastDay.day.mintempC
        self.condition = forecastDay.day.condition.text
        self.conditionIconURL = URL(string: "https:\(forecastDay.day.condition.icon)")
        self.chanceOfRain = forecastDay.day.dailyChanceOfRain

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: forecastDay.date) {
            dateFormatter.locale = Locale(identifier: "ru_RU")
            dateFormatter.dateFormat = "EEE"
            self.dayOfWeek = dateFormatter.string(from: date)
        } else {
            self.dayOfWeek = forecastDay.date
        }
    }
}

struct HourForecastModel {
    let time: String
    let temperature: Double
    let condition: String
    let conditionIconURL: URL?
    let chanceOfRain: Int
    let date: String
    let hour: Int

    init(from hourWeather: HourWeather) {
        let timeComponents = hourWeather.time.split(separator: " ")
        if timeComponents.count > 1 {
            let timeString = String(timeComponents[1])
            let hourString = timeString.split(separator: ":")[0]
            self.time = String(hourString)
            self.hour = Int(hourString) ?? 0
            self.date = String(timeComponents[0])
        } else {
            self.time = hourWeather.time
            self.hour = 0
            self.date = ""
        }

        self.temperature = hourWeather.tempC
        self.condition = hourWeather.condition.text
        self.conditionIconURL = URL(string: "https:\(hourWeather.condition.icon)")
        self.chanceOfRain = hourWeather.chanceOfRain
    }
}

enum WeatherCondition: Int, Decodable {
    case clear = 1000
    case partlyCloudy = 1003
    case cloudy = 1006
    case overcast = 1009
    case mist = 1030
    case fog = 1135
    case freezingFog = 1147
    case patchyRainPossible = 1063
    case patchySnowPossible = 1066
    case patchySleetPossible = 1069
    case patchyFreezingDrizzlePossible = 1072
    case thunderyOutbreaksPossible = 1087
    case blowingSnow = 1114
    case blizzard = 1117
    case patchyLightDrizzle = 1150
    case lightDrizzle = 1153
    case freezingDrizzle = 1168
    case heavyFreezingDrizzle = 1171
    case patchyLightRain = 1180
    case lightRain = 1183
    case moderateRainAtTimes = 1186
    case moderateRain = 1189
    case heavyRainAtTimes = 1192
    case heavyRain = 1195
    case lightFreezingRain = 1198
    case heavyFreezingRain = 1201
    case lightSleet = 1204
    case heavySleet = 1207
    case patchyLightSnow = 1210
    case lightSnow = 1213
    case patchyModerateSnow = 1216
    case moderateSnow = 1219
    case patchyHeavySnow = 1222
    case heavySnow = 1225
    case icePellets = 1237
    case lightRainShower = 1240
    case heavyRainShower = 1243
    case torrentialRainShower = 1246
    case lightSleetShowers = 1249
    case heavySleetShowers = 1252
    case lightSnowShowers = 1255
    case heavySnowShowers = 1258
    case lightIcePelletsShowers = 1261
    case heavyIcePelletsShowers = 1264
    case patchyRainWithThunder = 1273
    case heavyRainWithThunder = 1276
    case patchySnowWithThunder = 1279
    case heavySnowWithThunder = 1282
}

extension WeatherCondition {

    var localizedTitle: String {
        let key = "weather.\(rawValue)"
        let localized = NSLocalizedString(key, comment: "")
        return localized == key ? "-" : localized
    }
}
