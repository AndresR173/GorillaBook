//
//  BaseViewController.swift
//  GorillaBook
//
//  Created by Andres Felipe Rojas R. on 8/11/20.
//

import UIKit

class BaseViewController<View: UIView>: UIViewController {

    // MARK: - Properties

    var customView: View {
        return view as! View
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(recognizer:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    override func loadView() {
        view = View(frame: UIScreen.main.bounds)
    }

}
