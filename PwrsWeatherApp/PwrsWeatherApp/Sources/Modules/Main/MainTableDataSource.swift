//
//  MainTableDataSource.swift
//  PwrsWeatherApp
//
//  Created by Aysen Eremeev on 25.02.2026.
//

import UIKit

final class MainTableDataSource: NSObject, UITableViewDataSource {

    var state: MainState = .loading
    weak var delegate: MainViewControllerDelegate?

    private var viewModel: MainViewModel?

    func update(with state: MainState) {
        self.state = state
        if case let .result(mainViewModel) = state {
            self.viewModel = mainViewModel
        } else {
            self.viewModel = nil
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        switch state {
        case .loading, .error:
            return 1
        case let .result(mainViewModel):
            if !mainViewModel.hasForecast {
                return 1
            }

            return MainSection.allCases.count
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case .loading:
            return 1
        case .error:
            return 1
        case let .result(mainViewModel):
            if !mainViewModel.hasForecast {
                return 1
            }

            guard let mainSection = MainSection(rawValue: section) else {
                return 0
            }

            switch mainSection {
            case .current:
                return 1
            case .hourly:
                return 1
            case .daily:
                let count = mainViewModel.dailyForecast?.count ?? 0
                return count
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch state {
        case .loading:
            let cell = tableView.dequeueReusableCellWithRegistration(type: LoadingCell.self, indexPath: indexPath)
            return cell
        case let .error(message):
            let cell = tableView.dequeueReusableCellWithRegistration(type: ErrorCell.self, indexPath: indexPath)
            cell.configure(with: message)
            cell.onRetry = { [weak self] in
                self?.delegate?.refreshForecast()
            }
            return cell
        case let .result(mainViewModel):
            if !mainViewModel.hasForecast {
                let cell = tableView.dequeueReusableCellWithRegistration(type: CurrentWeatherCell.self, indexPath: indexPath)
                cell.configure(with: mainViewModel.currentWeather)
                return cell
            }

            guard let section = MainSection(rawValue: indexPath.section) else { return UITableViewCell()}

            switch section {
            case .current:
                let cell = tableView.dequeueReusableCellWithRegistration(type: CurrentWeatherCell.self, indexPath: indexPath)
                cell.configure(with: mainViewModel.currentWeather)
                return cell
            case .hourly:
                let cell = tableView.dequeueReusableCellWithRegistration(type: HourlyForecastCell.self, indexPath: indexPath)
                if let hourlyData = mainViewModel.hourlyForecast {
                    cell.configure(with: hourlyData)
                }
                return cell
            case .daily:
                let cell = tableView.dequeueReusableCellWithRegistration(type: DailyForecastCell.self, indexPath: indexPath)
                if let dailyData = mainViewModel.dailyForecast, indexPath.row < dailyData.count {
                    cell.configure(with: dailyData[indexPath.row])
                } else {
                }
                return cell
            }
        }
    }
}
