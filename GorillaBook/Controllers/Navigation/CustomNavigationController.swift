//
//  CustomNavigationController.swift
//  GorillaBook
//
//  Created by Andres Felipe Rojas R. on 8/11/20.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = .white
        navigationBarAppearace.barTintColor = UIColor(named: "mainColor")

        setViewControllers([FeedViewController()], animated: false)
        setupLogo()
    }

    private func setupLogo() {
        let logo = UIImage(named: "logo")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 25),
            imageView.heightAnchor.constraint(equalToConstant: 25),
            imageView.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor)
        ])
    }

}
