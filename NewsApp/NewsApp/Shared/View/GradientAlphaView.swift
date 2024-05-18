//
//  GradientAlphaView.swift
//  NewsApp
//
//  Created by Theo Necyk Agner Caldas on 15/05/24.
//

import UIKit

/// A view that sets alpha gradient overlay.
class GradientAlphaView: UIView {

    private var gradientLayer: CAGradientLayer?
    private var up: Bool = true
    
    /// Sets alpha gradient overlay. Can change color by backgroundColor.
    /// - Parameter up: Gradient vertical orientation.
    init(up: Bool) {
        self.up = up
        super.init(frame: .zero)
        setupGradient()
        isUserInteractionEnabled = false
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.black.withAlphaComponent(up ? 0.0 : 1.0).cgColor,
            UIColor.black.withAlphaComponent(up ? 1.0 : 0.0).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

        self.layer.mask = gradientLayer
        self.gradientLayer = gradientLayer
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.gradientLayer?.frame = self.bounds
    }
}
