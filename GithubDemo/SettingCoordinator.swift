//
//  SettingCoordinator.swift
//  GithubDemo
//
//  Created by apple on 5/30/17.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation
import UIKit

class SettingCoordinator: Coordinator {
    override func start() {
        let settingVc = mainStoryboard.instantiateViewController(withIdentifier: "setting_vc") as! SettingViewController
        //error
//        let settingVc = UINib(nibName: "SettingViewController", bundle: nil).instantiate(withOwner: nil, options: nil).first as! SettingViewController
        navigation?.interactivePopGestureRecognizer?.isEnabled = true
        navigation?.pushViewController(settingVc, animated: true)
    }
}
