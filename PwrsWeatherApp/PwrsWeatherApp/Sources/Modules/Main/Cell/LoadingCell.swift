//
//  LoadingCell.swift
//  PwrsWeatherApp
//
//  Created by Aysen Eremeev on 25.02.2026.
//

import UIKit

final class LoadingCell: UITableViewCell {

    private lazy var currentWeatherSkeletonView: SkeletonView = {
        let skeletonView = SkeletonView()
        skeletonView.layer.cornerRadius = 8
        skeletonView.layer.masksToBounds = true
        skeletonView.translatesAutoresizingMaskIntoConstraints = false
        return skeletonView
    }()

    private lazy var hourlyWeatherSkeletonView: SkeletonView = {
        let skeletonView = SkeletonView()
        skeletonView.layer.masksToBounds = true
        skeletonView.translatesAutoresizingMaskIntoConstraints = false
        return skeletonView
    }()

    private lazy var dailyForecastSkeletonView: SkeletonView = {
        let skeletonView = SkeletonView()
        skeletonView.layer.cornerRadius = 8
        skeletonView.layer.masksToBounds = true
        skeletonView.translatesAutoresizingMaskIntoConstraints = false
        return skeletonView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        contentView.addSubview(currentWeatherSkeletonView)
        contentView.addSubview(hourlyWeatherSkeletonView)
        contentView.addSubview(dailyForecastSkeletonView)

        NSLayoutConstraint.activate([
            currentWeatherSkeletonView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            currentWeatherSkeletonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            currentWeatherSkeletonView.trailingAnchor.constraint(equalTo:  contentView.trailingAnchor, constant: -16),
            currentWeatherSkeletonView.heightAnchor.constraint(equalToConstant: 250),

            hourlyWeatherSkeletonView.topAnchor.constraint(equalTo: currentWeatherSkeletonView.bottomAnchor, constant: 24),
            hourlyWeatherSkeletonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hourlyWeatherSkeletonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            hourlyWeatherSkeletonView.heightAnchor.constraint(equalToConstant: 100),

            dailyForecastSkeletonView.topAnchor.constraint(equalTo: hourlyWeatherSkeletonView.bottomAnchor, constant: 24),
            dailyForecastSkeletonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dailyForecastSkeletonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dailyForecastSkeletonView.heightAnchor.constraint(equalToConstant: 50),
            dailyForecastSkeletonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
