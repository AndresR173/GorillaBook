//
//  FeedView.swift
//  GorillaBook
//
//  Created by Andres Felipe Rojas R. on 8/11/20.
//

import UIKit

class FeedView: UIView {

    // MARK: - UIComponents

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.3664141815, green: 0.3664141815, blue: 0.3664141815, alpha: 1)
        label.font = .systemFont(ofSize: 16)

        return label
    }()

    lazy var greetingsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 28, weight: .bold)

        return label
    }()

    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8

        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(greetingsLabel)

        return stackView
    }()

    lazy var createPostView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "background")
        label.text = NSLocalizedString("What's on your mind?", comment: "")

        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])

        return view
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large

        return activityIndicator
    }()

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
        backgroundColor = UIColor(named: "background")

        addSubview(headerStackView)
        addSubview(createPostView)
        addSubview(tableView)

        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: readableContentGuide.topAnchor, constant: 8),
            headerStackView.leadingAnchor.constraint(equalTo: readableContentGuide.leadingAnchor, constant: 8),
            headerStackView.trailingAnchor.constraint(equalTo: readableContentGuide.trailingAnchor, constant: -8),

            createPostView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 8),
            createPostView.leadingAnchor.constraint(equalTo: leadingAnchor),
            createPostView.trailingAnchor.constraint(equalTo: trailingAnchor),
            createPostView.heightAnchor.constraint(equalToConstant: 60),

            tableView.topAnchor.constraint(equalTo: createPostView.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: readableContentGuide.bottomAnchor)
        ])

        showProgressIndicator()
    }
}

// MARK: - Internal Helpers
extension FeedView {
    func showProgressIndicator() {
        tableView.backgroundView = activityIndicator

        activityIndicator.startAnimating()
    }

    func hideProgressIndicator() {
        tableView.backgroundView = nil
    }
}
