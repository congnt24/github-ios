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
    var navigation: UINavigationController
    //must init storyboard in AppDelegate
    static var mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    init(_ navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func start() {
        
    }
}
