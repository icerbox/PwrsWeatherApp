//
//  HourlyCell.swift
//  PwrsWeatherApp
//
//  Created by Aysen Eremeev on 27.02.2026.
//

import UIKit

final class HourlyCell: UICollectionViewCell {

    static let reuseId = "HourlyCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white.withAlphaComponent(0.9)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemYellow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var precipitationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor(red: 0.0, green: 0.8, blue: 1.0, alpha: 1.0) // Ярко-голубой
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private func setupLayout() {
        contentView.addSubview(timeLabel)
        contentView.addSubview(iconImageView)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(precipitationLabel)

        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            timeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            iconImageView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 4),
            iconImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.heightAnchor.constraint(equalToConstant: 30),

            temperatureLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 4),
            temperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            precipitationLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 2),
            precipitationLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            precipitationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    func configure(with item: HourlyForecastItem) {
        timeLabel.text = item.time
        temperatureLabel.text = "\(item.temperature)°"

        if item.precipitation > 30 {
            iconImageView.image = UIImage(systemName: "cloud.rain.fill")
            iconImageView.tintColor = UIColor(red: 0.3, green: 0.6, blue: 1.0, alpha: 1.0)
        } else if item.precipitation > 0 {
            iconImageView.image = UIImage(systemName: "cloud.drizzle.fill")
            iconImageView.tintColor = UIColor(red: 0.4, green: 0.7, blue: 1.0, alpha: 1.0)
        } else {
            iconImageView.image = UIImage(systemName: "sun.max.fill")
            iconImageView.tintColor = .systemYellow
        }

        precipitationLabel.text = item.precipitation > 0 ? "\(item.precipitation)%" : nil
    }
}
