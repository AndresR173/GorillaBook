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
    var feed: [Feed] { get }
}

protocol FeedViewDelegate: class {
    func feedDidRefresh()
    func feedDidShowError(_ error: Error)
}

class FeedPresenterImpl {
    // MARK: Properties
    var feed: [Feed] = []
    weak var view: FeedViewDelegate?
    private var cancellables = Set<AnyCancellable>()

    let service: FeedService = FeedServiceClient()
}

extension FeedPresenterImpl: FeedPresenter {
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
