//
//  FeedPresenter.swift
//  GorillaBook
//
//  Created by Andres Felipe Rojas R. on 8/11/20.
//

import Foundation
import Combine

protocol FeedPresenter: class {
    func getFeed()
    func attachView(_ view: FeedViewDelegate)
    func addPost(_ post: String, image: Data?, createDate: Date)
    var feed: [Feed] { get }
}

protocol FeedViewDelegate: class {
    func feedDidRefresh()
    func feedDidShowError(_ error: Error)
    func feedDidInsertNewPost()
}

class FeedPresenterImpl {
    // MARK: Properties
    var feed: [Feed] = []
    weak var view: FeedViewDelegate?
    private var cancellables = Set<AnyCancellable>()

    let service: FeedService = FeedServiceClient()
}

extension FeedPresenterImpl: FeedPresenter {
    func addPost(_ post: String, image: Data?, createDate: Date) {
        let post = Feed(id: 0, firstName: "Jane", lastName: "", post: post, timestamp: String(createDate.timeIntervalSince1970), image: nil)
        feed.insert(post, at: 0)
        view?.feedDidInsertNewPost()
    }

    func getFeed() {
        service.getFeed()
            .mapError { [weak self] error -> Error in
                self?.view?.feedDidShowError(error)
                return error
            }
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] feed in
                    self?.feed = feed
                    self?.view?.feedDidRefresh()
                  }
            ).store(in: &cancellables)
    }

    func attachView(_ view: FeedViewDelegate) {
        self.view = view
    }
}
