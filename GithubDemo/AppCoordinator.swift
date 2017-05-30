//
//  AppCoordinator.swift
//  GithubDemo
//
//  Created by apple on 5/28/17.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    static var instance: AppCoordinator!
    override func start() {
        AppCoordinator.instance = self
        //navigate your screen here
        //add new coordinator to coordinators
        //for example: start login screen
        
        //check apptoken, if exist -> move to home else login
        let appToken = Token()
        if appToken.isTokenExist {
            let homeCoor = HomeCoordinator(navigation)
            homeCoor.start()
            coordinators["home"] = homeCoor
        }else{
            let loginCoor = LoginCoordinator(navigation)
            loginCoor.start()
            coordinators["login"] = loginCoor
        }
    }
    
    func startSetting(){
        SettingCoordinator(navigation).start()
    }
}
