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
import Localize_Swift

class HomeCoordinator: Coordinator {
    override func start() {
        let homeVC = Coordinator.mainStoryboard.instantiateViewController(withIdentifier: "home") as! HomeViewController
        homeVC.viewModel = HomeViewModel(provider: RxMoyaProvider<GitHub>(endpointClosure: endpointClosure))
        navigation.pushViewController(homeVC, animated: true)
        navigation.navigationBar.backgroundColor = UIColor.blue
//        navigation.navigationBar.
    }
}
