//
//  GithubError.swift
//  GithubDemo
//
//  Created by apple on 5/28/17.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation

enum GithubError: Error {
    case notAuthenticated
    case rateLimitExceeded
    case wrongJSONParsing
    case generic
}
