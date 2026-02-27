//
//  MainDataFlow.swift
//  PwrsWeatherApp
//
//  Created by Aysen Eremeev on 26.02.2026.
//

enum Main {

    // MARK: Получение прогноза погоды
    enum GetForecast {

        struct Request {
        }

        struct Response {
            let response: WeatherResponse
        }

        struct ViewModel {
            let viewModel: MainViewModel
        }
    }

    // MARK: Ошибка
    enum Error {
        struct Response {
            let message: String
        }

        struct ViewModel {
            let message: String
        }
    }
}
