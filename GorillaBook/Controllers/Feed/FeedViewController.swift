//
//  FeedViewController.swift
//  GorillaBook
//
//  Created by Andres Felipe Rojas R. on 8/11/20.
//

import UIKit

class FeedViewController: BaseViewController<FeedView> {

    let presenter: FeedPresenter = FeedPresenterImpl()

    // MARK: - Lyfe cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.attachView(self)

        setupUI()

        presenter.getFeed()
    }
}

// MARK: - Helpers
private extension FeedViewController {
    func setupUI() {
        customView.dateLabel.text = Date().getReadableDate()
        customView.greetingsLabel.text = "Hello Jane"

        customView.tableView.tableFooterView = UIView()
        customView.tableView.backgroundColor = UIColor(named: "background")
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
        customView.tableView.estimatedRowHeight = 200
        customView.tableView.separatorStyle = .none

        customView.tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: String(describing: FeedTableViewCell.self))

        customView.createPostView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(createPost)))
    }

    @objc func createPost() {
        let viewController = CreatePostViewController()
        viewController.delegate = self
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - FeedViewDelegate
extension FeedViewController: FeedViewDelegate {
    func feedDidInsertNewPost() {
        customView.tableView.beginUpdates()
        customView.tableView.insertRows(at: [NSIndexPath(row: 0, section: 0) as IndexPath], with: .automatic)
        customView.tableView.endUpdates()
    }

    func feedDidShowError(_ error: Error) {
        let alert = UIAlertController(title: "Feed", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default))
        present(alert, animated: true)
    }

    func feedDidRefresh() {
        customView.hideProgressIndicator()
        customView.tableView.reloadData()
    }
}

// MARK: - UITableView Delegate & Datasource
extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.feed.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FeedTableViewCell.self)) as! FeedTableViewCell
        cell.feed = presenter.feed[indexPath.row]

        return cell
    }
}

// MARK: - CreatePostDelegate
extension FeedViewController: CreatePostDelegate {
    func feedDidAddPost(_ post: String, image: Data?, date: Date) {
        presenter.addPost(post, image: image, createDate: date)
    }
}
