//
//  ViewController.swift
//  PwrsWeatherApp
//
//  Created by Aysen Eremeev on 25.02.2026.
//

import UIKit

protocol MainDisplayLogic: AnyObject {

    /// Отображение результата получения прогноза погоды
    func displayResult(state: MainState)
}

protocol MainViewControllerDelegate: AnyObject {

    /// Обновить прогноз погоды
    func refreshForecast()
}

final class MainViewController: UIViewController {

    private let interactor: MainBusinessLogic
    private let tableDataSource = MainTableDataSource()
    private lazy var customView = self.view as? MainView

    init(interactor: MainBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = MainView(
            frame: .zero,
            tableDataSource: tableDataSource,
            delegate: self
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getForecast()
    }

    func getForecast() {
        interactor.getForecast()
    }
}

extension MainViewController: MainDisplayLogic {

    func displayResult(state: MainState) {
        tableDataSource.state = state
        customView?.updateTableView()
    }
}

extension MainViewController: MainViewControllerDelegate {

    // Обновить прогноз погоды
    func refreshForecast() {
        getForecast()
    }
}
