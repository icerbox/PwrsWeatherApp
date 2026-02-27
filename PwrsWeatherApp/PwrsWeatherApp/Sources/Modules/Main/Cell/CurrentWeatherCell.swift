//
//  CurrentWeatherCell.swift
//  PwrsWeatherApp
//
//  Created by Aysen Eremeev on 25.02.2026.
//

import UIKit

final class CurrentWeatherCell: UITableViewCell {

    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 72, weight: .thin)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var conditionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var highLowLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var weatherIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .systemYellow
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private lazy var detailsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupLayout() {
        contentView.addSubview(locationLabel)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(weatherIconImageView)
        contentView.addSubview(conditionLabel)
        contentView.addSubview(highLowLabel)
        contentView.addSubview(detailsStackView)

        let feelsLikeView = createDetailView(icon: "thermometer", title: "ОЩУЩАЕТСЯ КАК")
        let humidityView = createDetailView(icon: "humidity", title: "ВЛАЖНОСТЬ")
        let windView = createDetailView(icon: "wind", title: "ВЕТЕР")
        let uvView = createDetailView(icon: "sun.max", title: "УФ")

        [feelsLikeView, humidityView, windView, uvView].forEach {
            detailsStackView.addArrangedSubview($0)
        }

        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            temperatureLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 8),
            temperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            weatherIconImageView.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 8),
            weatherIconImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherIconImageView.widthAnchor.constraint(equalToConstant: 50),
            weatherIconImageView.heightAnchor.constraint(equalToConstant: 50),

            conditionLabel.topAnchor.constraint(equalTo: weatherIconImageView.bottomAnchor, constant: 8),
            conditionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            highLowLabel.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor, constant: 4),
            highLowLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            detailsStackView.topAnchor.constraint(equalTo: highLowLabel.bottomAnchor, constant: 24),
            detailsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            detailsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            detailsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }

    private func createDetailView(icon: String, title: String) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let imageView = UIImageView(image: UIImage(systemName: icon))
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 12, weight: .medium)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let valueLabel = UILabel()
        valueLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        valueLabel.textAlignment = .center
        valueLabel.textColor = .white
        valueLabel.tag = 100
        valueLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(valueLabel)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            valueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            valueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        return view
    }

    // MARK: - Configuration
    func configure(with viewModel: CurrentWeatherViewModel) {
        locationLabel.text = viewModel.locationName
        temperatureLabel.text = "\(Int(viewModel.temperature))°"
        conditionLabel.text = viewModel.condition
        highLowLabel.text = viewModel.highLow

        weatherIconImageView.image = UIImage(systemName: "sun.max.fill")

        if let feelsLikeView = detailsStackView.arrangedSubviews[0].viewWithTag(100) as? UILabel {
            feelsLikeView.text = "\(Int(viewModel.feelsLike))°"
        }

        if let humidityView = detailsStackView.arrangedSubviews[1].viewWithTag(100) as? UILabel {
            humidityView.text = "\(viewModel.humidity)%"
        }

        if let windView = detailsStackView.arrangedSubviews[2].viewWithTag(100) as? UILabel {
            windView.text = String(format: "%.0f", viewModel.windSpeed)
        }

        if let uvView = detailsStackView.arrangedSubviews[3].viewWithTag(100) as? UILabel {
            let uvValue = Int(viewModel.uvIndex)
            switch uvValue {
            case 0...2: uvView.text = "Низкий"
            case 3...5: uvView.text = "Средний"
            case 6...7: uvView.text = "Высокий"
            case 8...10: uvView.text = "Очень высокий"
            default: uvView.text = "Экстремальный"
            }
        }
    }
}
