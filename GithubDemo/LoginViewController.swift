//
//  LoginViewController.swift
//  GithubDemo
//
//  Created by apple on 5/28/17.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    //MARK: - var outlet
    @IBOutlet weak var tfUser: UITextField!
    @IBOutlet weak var tfPass: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    //MARK: - Vars
    let disposeBag = DisposeBag()
    var viewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
    }
    
    func setupRx(){
        //Bind outlet to input
        tfUser.rx.text.orEmpty
            .bind(to: viewModel.username).addDisposableTo(disposeBag)
        tfPass.rx.text.orEmpty
            .bind(to: viewModel.password).addDisposableTo(disposeBag)
        btnLogin.rx.tap.bind(to: viewModel.loginTap).addDisposableTo(disposeBag)
        //bind output to UI
        let login = btnLogin.rx.isEnabled
        viewModel.loginEnable.drive(login).addDisposableTo(disposeBag)
        
        viewModel.loginFinished.drive(onNext: { (result) in
            switch result {
                case .ok:
                    self.showDialog("Success", "Login success")
                break
                case .error(let message):
                    
                    self.showDialog("Error", "Login Error \(message)")
                break
                
            }
        })
            .addDisposableTo(disposeBag)
    }    
}
