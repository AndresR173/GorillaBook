//
//  Constants.swift
//  GorillaBook
//
//  Created by Andres Felipe Rojas R. on 8/11/20.
//

import Foundation

struct Constants {
    struct Api {
        static let host = "gl-endpoint.herokuapp.com"
        static let scheme = "https"

        static func getBaseURLComponents() -> URLComponents {
            var components = URLComponents()
            components.scheme = Constants.Api.scheme
            components.host = Constants.Api.host

            return components
        }

        struct Paths {
            static let feed = "/feed"
        }
    }
}
