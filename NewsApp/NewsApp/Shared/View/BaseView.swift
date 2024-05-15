//
//  BaseView.swift
//  NewsApp
//
//  Created by Theo Necyk Agner Caldas on 14/05/24.
//

import Foundation

// MARK: - Base View Protocol
protocol BaseView {
    /// Calls other setup functions.
    func setupView()
    func addSubviews()
    func setupStyles()
    func setupConstraints()
}

extension BaseView {
    func setupView() {
        addSubviews()
        setupStyles()
        setupConstraints()
    }
}
