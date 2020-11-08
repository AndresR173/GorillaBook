//
//  FeedView.swift
//  GorillaBook
//
//  Created by Andres Felipe Rojas R. on 8/11/20.
//

import UIKit

class FeedView: UIView {

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers

private extension FeedView {
    func setupUI() {
        backgroundColor = .white
    }
}
