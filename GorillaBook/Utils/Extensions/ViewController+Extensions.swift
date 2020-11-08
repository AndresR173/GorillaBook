//
//  ViewController+Extensions.swift
//  GorillaBook
//
//  Created by Andres Felipe Rojas R. on 8/11/20.
//

import UIKit

extension UIViewController {
    @objc func dismissKeyboard(recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
