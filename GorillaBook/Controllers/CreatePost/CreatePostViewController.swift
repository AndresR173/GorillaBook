//
//  CreateViewController.swift
//  GorillaBook
//
//  Created by Andres Felipe Rojas R. on 8/11/20.
//

import UIKit

protocol CreatePostDelegate: class {
    func feedDidAddPost(_ post: String, image: Data?, date: Date)
}

class CreatePostViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var postLenghtLabel: UILabel!
    @IBOutlet weak var addPhotoButton: UIButton!
    
    // MARK: - Properties
    let MAX_LENGTH: Int = 150

    private lazy var shareButton: UIBarButtonItem = {
        return UIBarButtonItem(title: NSLocalizedString("Share", comment: ""),
                                                    style: .plain,
                                                    target: self,
                                                    action: #selector(sharePost))
    }()

    weak var delegate: CreatePostDelegate?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

}

private extension CreatePostViewController {
    func setupUI() {
        title = NSLocalizedString("Create Post", comment: "")

        navigationItem.rightBarButtonItem = shareButton
        shareButton.isEnabled = false

        postTextView.delegate = self
    }

    @objc func sharePost() {
        delegate?.feedDidAddPost(postTextView.text, image: nil, date: Date())
        navigationController?.popViewController(animated: true)
    }
}


extension CreatePostViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        return numberOfChars <= MAX_LENGTH
    }

    func textViewDidChange(_ textView: UITextView) {
        let count = textView.text.count
        postLenghtLabel.text = "\(count)/150"
        shareButton.isEnabled = count > 0
    }
}
