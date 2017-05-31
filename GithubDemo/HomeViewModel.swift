//
//  HomeViewModel.swift
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

enum SearchResult {
    case ok(repos: Repos)
    case error(msg: String)
}

struct Repos {
    var repos = [RepoResult]()
    
    init (_ json: JSON){
        let arr = json["items"].arrayValue
        for item in arr {
            repos.append(RepoResult(item))
        }
    }
}
struct RepoResult {
    var name: String
    var description: String
    
    init (_ json: JSON){
        name = json["name"].stringValue
        description = json["description"].stringValue
    }
}

class HomeViewModel: BaseViewModel {
    //delegate
    var coordinatorDelegate: HomeSelectItemInTableCiew!
    //Input
    var searchText = Variable("")
    //output
    var searchFinished: Driver<SearchResult>
    
    init(provider: RxMoyaProvider<GitHub>) {
        //initialize output from input
        searchFinished =
            searchText.asObservable().distinctUntilChanged()
        .debounce(0.5, scheduler: MainScheduler.instance)
        .flatMapLatest {
            provider.request(.repoSearch(query: $0))
            .retry(3)
            .observeOn(MainScheduler.instance)
        }
        .map { (response: Response) in
//            print(response.response)
            if response.statusCode == 200 {
                return SearchResult.ok(repos: Repos(JSON(response.data)))
            } else {
                return SearchResult.error(msg: "oops")
            }
        }
        .asDriver(onErrorJustReturn: SearchResult.error(msg: "oops"))
        
    }
    
    func goDetails() -> Void {
        coordinatorDelegate.onClick()
    }
}
