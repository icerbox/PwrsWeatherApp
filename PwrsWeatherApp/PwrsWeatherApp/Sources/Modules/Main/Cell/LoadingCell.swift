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
        skeletonView.layer.cornerRadius = 16
        skeletonView.layer.masksToBounds = true
        skeletonView.translatesAutoresizingMaskIntoConstraints = false
        return skeletonView
    }()

    private lazy var currentConditionsSkeletonView: SkeletonView = {
        let skeletonView = SkeletonView()
        skeletonView.layer.masksToBounds = true
        skeletonView.translatesAutoresizingMaskIntoConstraints = false
        return skeletonView
    }()

    private lazy var hourlyWeatherSkeletonView: SkeletonView = {
        let skeletonView = SkeletonView()
        skeletonView.layer.cornerRadius = 16
        skeletonView.layer.masksToBounds = true
        skeletonView.translatesAutoresizingMaskIntoConstraints = false
        return skeletonView
    }()

    private lazy var dailyForecastSkeletonView1: SkeletonView = {
        let skeletonView = SkeletonView()
        skeletonView.layer.cornerRadius = 16
        skeletonView.layer.masksToBounds = true
        skeletonView.translatesAutoresizingMaskIntoConstraints = false
        return skeletonView
    }()

    private lazy var dailyForecastSkeletonView2: SkeletonView = {
        let skeletonView = SkeletonView()
        skeletonView.layer.cornerRadius = 16
        skeletonView.layer.masksToBounds = true
        skeletonView.translatesAutoresizingMaskIntoConstraints = false
        return skeletonView
    }()

    private lazy var dailyForecastSkeletonView3: SkeletonView = {
        let skeletonView = SkeletonView()
        skeletonView.layer.cornerRadius = 16
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
        contentView.addSubview(currentConditionsSkeletonView)
        contentView.addSubview(hourlyWeatherSkeletonView)
        contentView.addSubview(dailyForecastSkeletonView1)
        contentView.addSubview(dailyForecastSkeletonView2)
        contentView.addSubview(dailyForecastSkeletonView3)

        NSLayoutConstraint.activate([
            currentWeatherSkeletonView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            currentWeatherSkeletonView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            currentWeatherSkeletonView.widthAnchor.constraint(equalToConstant: 100),
            currentWeatherSkeletonView.heightAnchor.constraint(equalToConstant: 180),

            currentConditionsSkeletonView.topAnchor.constraint(equalTo: currentWeatherSkeletonView.bottomAnchor, constant: 16),
            currentConditionsSkeletonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            currentConditionsSkeletonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            currentConditionsSkeletonView.heightAnchor.constraint(equalToConstant: 80),

            hourlyWeatherSkeletonView.topAnchor.constraint(equalTo: currentConditionsSkeletonView.bottomAnchor, constant: 24),
            hourlyWeatherSkeletonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            hourlyWeatherSkeletonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            hourlyWeatherSkeletonView.heightAnchor.constraint(equalToConstant: 150),

            dailyForecastSkeletonView1.topAnchor.constraint(equalTo: hourlyWeatherSkeletonView.bottomAnchor, constant: 16),
            dailyForecastSkeletonView1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dailyForecastSkeletonView1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dailyForecastSkeletonView1.heightAnchor.constraint(equalToConstant: 40),

            dailyForecastSkeletonView2.topAnchor.constraint(equalTo: dailyForecastSkeletonView1.bottomAnchor, constant: 12),
            dailyForecastSkeletonView2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dailyForecastSkeletonView2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dailyForecastSkeletonView2.heightAnchor.constraint(equalToConstant: 40),

            dailyForecastSkeletonView3.topAnchor.constraint(equalTo: dailyForecastSkeletonView2.bottomAnchor, constant: 12),
            dailyForecastSkeletonView3.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dailyForecastSkeletonView3.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dailyForecastSkeletonView3.heightAnchor.constraint(equalToConstant: 40),
            dailyForecastSkeletonView3.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
