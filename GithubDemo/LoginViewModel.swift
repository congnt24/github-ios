//
//  LoginViewModel.swift
//  GithubDemo
//
//  Created by apple on 5/28/17.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
import SwiftyJSON

enum LoginResult {
    case ok
    case error(message: String)
}
class LoginViewModel: BaseViewModel {
    //MARK: - input
    var username = Variable("")
    var password = Variable("")
    var loginTap = PublishSubject<Void>()
    //MARK: - output
    
    var loginEnable: Driver<Bool>
    var loginFinished: Driver<LoginResult>
    var loginExecuting:  Driver<Bool>
    
    init(provider: RxMoyaProvider<GitHub>){
        //init all output variable to observable
        
        let usernameObservable = username.asObservable()
        let passwordObservable = password.asObservable()
        
        loginEnable = Observable.combineLatest(usernameObservable, passwordObservable, resultSelector: { $0.characters.count > 0 && $1.characters.count > 0 }).asDriver(onErrorJustReturn: false)
        
        loginExecuting = Variable(false).asDriver().distinctUntilChanged()
        
        //MARK: - reference: https://stackoverflow.com/questions/28580490/rxjava-how-to-emulate-withlatestfrom
        //return a pair of user and password
        let combineUserAndPassFromLatest = Observable.combineLatest(usernameObservable, passwordObservable, resultSelector: {($0, $1)})
        
        loginFinished = loginTap.asObserver().withLatestFrom(combineUserAndPassFromLatest)
        .flatMapLatest({ (username, password) in
            provider.request(GitHub.token(username: username, password: password))
            .filter(statusCodes: 200...201)
            .retry(3)
            .observeOn(MainScheduler.instance)
        })
        .map {response in
            //TODO: get an save token here
            var appToken = Token()
            appToken.token = JSON(response.data)["token"].stringValue
            return LoginResult.ok
        }
        .asDriver(onErrorJustReturn: LoginResult.error(message: "oops")).debug()
        
    }
}
