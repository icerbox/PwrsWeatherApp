//
//  SkeletonView.swift
//  PwrsWeatherApp
//
//  Created by Aysen Eremeev on 26.02.2026.
//

import UIKit

final class SkeletonView: UIView {

    private enum ViewMetrics {
        static let backgroundColor: UIColor = .lightGray
        static let animationDuration: CFTimeInterval = 0.5
    }

    private lazy var backgroundLayer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = ViewMetrics.backgroundColor.cgColor
        layer.frame = self.bounds
        return layer
    }()

    required init() {
        super.init(frame: .zero)
        startAnimating()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradientFrame()
    }

    private func updateGradientFrame() {
        backgroundLayer.frame = bounds
    }

    private func startAnimating() {
        self.layer.addSublayer(backgroundLayer)
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        animation.fromValue = 0.2
        animation.toValue = 0.5
        animation.duration = ViewMetrics.animationDuration
        animation.autoreverses = true
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.isRemovedOnCompletion = false

        let animationGroup = CAAnimationGroup()
        animationGroup.duration = ViewMetrics.animationDuration * 2
        animationGroup.animations = [animation]
        animationGroup.repeatCount = .infinity
        animationGroup.isRemovedOnCompletion = false

        backgroundLayer.add(animationGroup, forKey: animation.keyPath)
    }

    private func stopAnimating() {
        backgroundLayer.removeAllAnimations()
        backgroundLayer.removeFromSuperlayer()
    }

    func setBackgroundColor(_ color: UIColor) {
        backgroundLayer.backgroundColor = color.cgColor
    }

    func setMaskingViews(_ views: [UIView]) {
        let mutablePath = CGMutablePath()

        views.forEach { view in
            guard self.subviews.contains(view) else {
                fatalError("View:\(view) is not a subView of \(self). Therefore, it cannot be a masking view.")
            }

            if view.layer.cornerRadius == view.frame.size.height / 2, view.layer.cornerRadius == view.frame.size.width / 2, view.layer.masksToBounds {
                mutablePath.addEllipse(in: view.frame)
            } else if view.layer.masksToBounds,
                      view.frame.height / 2 >= view.layer.cornerRadius {
                mutablePath.addRoundedRect(in: view.frame, cornerWidth: view.layer.cornerRadius, cornerHeight: view.layer.cornerRadius)
            } else {
                mutablePath.addRoundedRect(in: view.frame, cornerWidth: view.frame.height / 3, cornerHeight: view.frame.height / 3)
            }
        }

        let maskLayer = CAShapeLayer()
        maskLayer.path = mutablePath

        self.layer.mask = maskLayer
    }
}
