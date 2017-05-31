//
//  SettingViewController.swift
//  GithubDemo
//
//  Created by apple on 5/30/17.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let backButton = UIButton()
//        //        backButton.titleLabel?.text = "<"
//        backButton.setImage(R.image.icons8Search_filled(), for: UIControlState.normal)
//        backButton.frame = CGRect(x: 0, y: 0, width: 33/2, height: 27/2)
//        let backBarItem = UIBarButtonItem(customView: backButton)
//        navigationItem.leftBarButtonItem = backBarItem
//        navigationController!.interactivePopGestureRecognizer?.isEnabled = true
        navigationController!.interactivePopGestureRecognizer?.delegate = nil
        title = "Setting"
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func back(_ sender: Any) {
        popViewController()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
