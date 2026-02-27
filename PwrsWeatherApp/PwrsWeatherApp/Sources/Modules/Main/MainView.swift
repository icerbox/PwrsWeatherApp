//
//  MainView.swift
//  PwrsWeatherApp
//
//  Created by Aysen Eremeev on 25.02.2026.
//

import UIKit

final class MainView: UIView {

    private weak var delegate: MainViewControllerDelegate?

    private lazy var gradientBackgroundView: GradientView = {
        let view = GradientView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.refreshControl = refreshControl
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return refreshControl
    }()

    init(frame: CGRect,
         tableDataSource: UITableViewDataSource,
         delegate: MainViewControllerDelegate
    ) {
        self.delegate = delegate
        super.init(frame: frame)
        tableView.dataSource = tableDataSource
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func refreshData() {
        delegate?.refreshForecast()
    }
    
    private func setupLayout() {
        addSubview(gradientBackgroundView)
        addSubview(tableView)
        NSLayoutConstraint.activate([
            gradientBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            gradientBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gradientBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            gradientBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),

            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func updateTableView() {
        tableView.reloadData()
        self.refreshControl.endRefreshing()   
    }
}
