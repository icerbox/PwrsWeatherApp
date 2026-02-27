//
//  DailtyForecastCell.swift
//  PwrsWeatherApp
//
//  Created by Aysen Eremeev on 25.02.2026.
//

import UIKit

final class DailyForecastCell: UITableViewCell {

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.2, alpha: 0.3)
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .systemYellow
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private lazy var precipitationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var lowTempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white.withAlphaComponent(0.7)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var highTempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        contentView.addSubview(containerView)
        containerView.addSubview(dayLabel)
        containerView.addSubview(iconImageView)
        containerView.addSubview(precipitationLabel)
        containerView.addSubview(lowTempLabel)
        containerView.addSubview(highTempLabel)
        containerView.addSubview(separatorView)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),

            dayLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            dayLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            dayLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            dayLabel.widthAnchor.constraint(equalToConstant: 50),

            iconImageView.leadingAnchor.constraint(equalTo: dayLabel.trailingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: dayLabel.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.heightAnchor.constraint(equalToConstant: 30),

            precipitationLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            precipitationLabel.centerYAnchor.constraint(equalTo: dayLabel.centerYAnchor),
            precipitationLabel.widthAnchor.constraint(equalToConstant: 45),

            highTempLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            highTempLabel.centerYAnchor.constraint(equalTo: dayLabel.centerYAnchor),

            lowTempLabel.trailingAnchor.constraint(equalTo: highTempLabel.leadingAnchor, constant: -16),
            lowTempLabel.centerYAnchor.constraint(equalTo: dayLabel.centerYAnchor),

            separatorView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            separatorView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            separatorView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }

    func configure(with item: DailyForecastItem) {
        dayLabel.text = item.day
        lowTempLabel.text = "\(item.lowTemp)°"
        highTempLabel.text = "\(item.highTemp)°"

        if item.precipitation > 50 {
            iconImageView.image = UIImage(systemName: "cloud.heavyrain.fill")
            iconImageView.tintColor = UIColor(red: 0.2, green: 0.5, blue: 1.0, alpha: 1.0)
        } else if item.precipitation > 0 {
            iconImageView.image = UIImage(systemName: "cloud.rain.fill")
            iconImageView.tintColor = UIColor(red: 0.3, green: 0.6, blue: 1.0, alpha: 1.0)
        } else {
            iconImageView.image = UIImage(systemName: "sun.max.fill")
            iconImageView.tintColor = .systemYellow
        }

        precipitationLabel.text = item.precipitation > 0 ? "\(item.precipitation)%" : nil
    }
}
