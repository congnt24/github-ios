//
//  BaseUIExtension.swift
//  GithubDemo
//
//  Created by Cong on 5/30/17.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func popViewController(){
        if let navigation = navigationController {
            navigation.popViewController(animated: true)
        }
    }
}
