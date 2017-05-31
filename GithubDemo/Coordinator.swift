//
//  Coordinator.swift
//  GithubDemo
//
//  Created by apple on 5/28/17.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation
import UIKit

class Coordinator {
    var coordinators = [String: Any]()
    var navigation: UINavigationController?
    var window: UIWindow?
    //must init storyboard in AppDelegate
    var mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    init(_ navigation: UINavigationController?, window: UIWindow? = nil) {
        self.window = window
        self.navigation = navigation
    }
    
    func start() {
        
    }
}
