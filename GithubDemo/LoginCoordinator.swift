//
//  LoginCoordinator.swift
//  GithubDemo
//
//  Created by apple on 5/28/17.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation
import UIKit
import Moya

class LoginCoordinator: Coordinator {
    override func start() {
        let loginVC = mainStoryboard.instantiateViewController(withIdentifier: "login") as!LoginViewController
        //can create view model and pass to viewcontroller here
        let viewModel = LoginViewModel(provider: RxMoyaProvider<GitHub>(endpointClosure: endpointClosure))
        loginVC.viewModel = viewModel
        navigation?.popToRootViewController(animated: false)
//        navigation.pushViewController(loginVC, animated: true)
        //set root view controller
        navigation?.setViewControllers([UIViewController](repeating: loginVC, count: 1), animated: true)
    }
}
