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
import SlideMenuControllerSwift

protocol HomeCoordinatorDelegate {
    func didFinishHomeCoordinator(homeCoordinator: HomeCoordinator)
}

protocol HomeSelectItemInTableCiew {
    func onClick()
}

class HomeCoordinator: Coordinator {
    override func start() {
        let homeVC = mainStoryboard.instantiateViewController(withIdentifier: "home") as! HomeViewController
        homeVC.viewModel = HomeViewModel(provider: RxMoyaProvider<GitHub>(endpointClosure: endpointClosure))
        homeVC.viewModel.coordinatorDelegate = self
        navigation?.popToRootViewController(animated: false)
        navigation?.setViewControllers([homeVC], animated: true)
//        navigation.pushViewController(homeVC, animated: true)
    }
}

extension HomeCoordinator: HomeSelectItemInTableCiew {
    func onClick() {
        //switch to other screen
        SettingCoordinator(navigation).start()
    }
}
