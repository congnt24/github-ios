//
//  BaseViewModel.swift
//  GithubDemo
//
//  Created by apple on 5/29/17.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation
//should not import uikit in viewmodel

protocol BaseViewModel: class {
    
}

protocol BaseApiViewModel: class {
    associatedtype Service
    var service: Service { get }
    init(_ service: Service)
}
