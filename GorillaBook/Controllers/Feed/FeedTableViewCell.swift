//
//  FeedTableViewCell.swift
//  GorillaBook
//
//  Created by Andres Felipe Rojas R. on 8/11/20.
//

import UIKit
import SDWebImage

class FeedTableViewCell: UITableViewCell {

    // MARK: - UI Components

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .bold)

        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
        label.font = .systemFont(ofSize: 14)

        return label
    }()

    private lazy var postLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)

        return label
    }()

    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.backgroundColor = .white

        let headerStackView = UIStackView()
        headerStackView.axis = .vertical
        headerStackView.addArrangedSubview(nameLabel)
        headerStackView.addArrangedSubview(dateLabel)

        stackView.addArrangedSubview(headerStackView)
        stackView.addArrangedSubview(postLabel)
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(separator)

        NSLayoutConstraint.activate([
            headerStackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 8),
            headerStackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -8),
            separator.heightAnchor.constraint(equalToConstant: 8)
        ])

        return stackView
    }()

    // MARK: - Properties
    var feed: Feed? {
        didSet {
            showInfo()
        }
    }

    private lazy var postImageHeightConstraint: NSLayoutConstraint = {
        return postImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5)
    }()

    private lazy var postImageHiddenHeightConstraint: NSLayoutConstraint = {
        return postImageView.heightAnchor.constraint(equalToConstant: 0.1)
    }()


    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.backgroundColor = UIColor(named: "background")
        contentView.addSubview(contentStackView)
        contentView.addSubview(postImageView)

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            postImageView.topAnchor.constraint(equalTo: contentStackView.bottomAnchor),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            postImageHeightConstraint
        ])
    }

    private func showInfo() {
        guard let info = feed else { return }
        nameLabel.text = info.fullName
        postLabel.text = info.post

        if let date = Double(info.timestamp) {
            dateLabel.text = date.getDateFromUnixTimestamp()
        }

        if let image = info.image {
            postImageView.sd_setImage(with: URL(string: image))
            postImageHeightConstraint.isActive = true
            postImageHiddenHeightConstraint.isActive = false
        } else {
            postImageHeightConstraint.isActive = false
            postImageHiddenHeightConstraint.isActive = true
        }
    }
}
