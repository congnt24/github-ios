//
//  HomeCoordinator.swift
//  GithubDemo
//
//  Created by apple on 5/28/17.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation
import UIKit
import Moya

class HomeCoordinator: Coordinator {
    override func start() {
        let homeVC = Coordinator.mainStoryboard.instantiateViewController(withIdentifier: "home") as! HomeViewController
        homeVC.viewModel = HomeViewModel(provider: RxMoyaProvider<GitHub>(endpointClosure: endpointClosure))
        navigation.popToRootViewController(animated: false)
        navigation.navigationBar.backgroundColor = UIColor.blue
        navigation.setViewControllers([UIViewController](repeating: homeVC, count: 1), animated: true)
//        navigation.pushViewController(homeVC, animated: true)
    }
}
