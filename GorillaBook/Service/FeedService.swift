//
//  FeedService.swift
//  GorillaBook
//
//  Created by Andres Felipe Rojas R. on 8/11/20.
//

import Foundation
import Combine

protocol FeedService {
    func getFeed() -> AnyPublisher<[Feed], Error>
}

final class FeedServiceClient {
    private let apiClient = APIClient()

    private func getFeedFromApi() -> AnyPublisher<[Feed], Error> {
        var urlComponents = Constants.Api.getBaseURLComponents()
        urlComponents.path = Constants.Api.Paths.feed
        
        guard let url = urlComponents.url else {
            return Fail(error: NetworkError.badRequest).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return apiClient.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}

extension FeedServiceClient: FeedService {
    func getFeed() -> AnyPublisher<[Feed], Error> {
        return getFeedFromApi()
    }
}
