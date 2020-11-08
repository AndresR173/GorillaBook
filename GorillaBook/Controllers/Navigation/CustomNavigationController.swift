//
//  CustomNavigationController.swift
//  GorillaBook
//
//  Created by Andres Felipe Rojas R. on 8/11/20.
//

import UIKit

class CustomNavigationController: UINavigationController {

    private lazy var logoImageView: UIImageView = {
        let logo = UIImage(named: "logo")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self

        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = .white
        navigationBarAppearace.barTintColor = UIColor(named: "mainColor")

        setViewControllers([FeedViewController()], animated: false)
        setupLogo()
    }

    private func setupLogo() {
        navigationBar.addSubview(logoImageView)

        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 25),
            logoImageView.heightAnchor.constraint(equalToConstant: 25),
            logoImageView.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor)
        ])
    }

    private func hideLogo() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {[weak self] in
            self?.logoImageView.alpha = 0.0
        }
    }

    private func showLogo() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {[weak self] in
            self?.logoImageView.alpha = 1.0
        }
    }

}

extension CustomNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            hideLogo()
        } else {
            showLogo()
        }
        return nil
    }
}
