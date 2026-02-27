//
//  GradientView.swift
//  PwrsWeatherApp
//
//  Created by Aysen Eremeev on 27.02.2026.
//

import UIKit

final class GradientView: UIView {

    private let gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupGradient() {
        gradientLayer.colors = [
            UIColor(red: 0.4, green: 0.8, blue: 1.0, alpha: 1.0).cgColor,
            UIColor(red: 0.2, green: 0.5, blue: 0.9, alpha: 1.0).cgColor,
            UIColor(red: 0.1, green: 0.2, blue: 0.6, alpha: 1.0).cgColor
        ]

        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

        layer.insertSublayer(gradientLayer, at: 0)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
