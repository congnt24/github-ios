//
//  HomeViewController.swift
//  GithubDemo
//
//  Created by apple on 5/28/17.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import SwiftyJSON
import RxDataSources

class HomeViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var searchView: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var uiRefresh = UIRefreshControl()
    var viewModel: HomeViewModel!
    let disposeBag = DisposeBag()
    var repo = PublishSubject<[SectionModel<String, RepoResult>]>()
    var repos = Variable<[SectionModel<String, RepoResult>]>([])
    
    var dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, RepoResult>>()
    override func viewDidLoad() {
        tableView.register(UINib(nibName: "RepoTableViewCell", bundle: nil), forCellReuseIdentifier: "homecell2")
        
        uiRefresh.attributedTitle = NSAttributedString(string: "Pull to refresh")
        uiRefresh.addTarget(self, action: #selector(refresh(sender:)), for: UIControlEvents.valueChanged)
        tableView.addSubview(uiRefresh)
        setupRx()
        
        title = "hello".localized()
        
    }
    func refresh(sender: AnyObject){
//        print("refresh")
        uiRefresh.endRefreshing()
    }
    
    func setupRx() {
        searchView.rx.text.orEmpty
            .bind(to: viewModel.searchText).addDisposableTo(disposeBag)
        
        viewModel.searchFinished.drive(onNext: {
            switch $0 {
            case .ok(let repos):
                //use for load more
                self.repos.value.append(SectionModel(model: "header", items: repos.repos))
                //use for reload
                self.repo.onNext([SectionModel(model: "header", items: repos.repos)])
                break
            case .error(_):
                    //show error
//                self.repo.onError(GithubError.generic)
                self.repo.onNext([SectionModel<String, RepoResult>]())
                break
            }
        }).addDisposableTo(disposeBag)
        
        dataSource.configureCell = { ds /*datasource*/, tv /*tableView*/,ip ,item in
            let cell = tv.dequeueReusableCell(withIdentifier: "homecell2") as! RepoTableViewCell
            cell.title.text = item.name
            cell.desc.text = item.description
            return cell
        }
        
        tableView.rx.setDelegate(self).addDisposableTo(disposeBag)
        
        dataSource.titleForHeaderInSection = { dataSource, sectionIndex in
            return dataSource[sectionIndex].model
        }
//
//        dataSource._rx_tableView(tableView, titleForHeaderInSection: 0)
        
        repo.asObserver().catchErrorJustReturn([SectionModel<String, RepoResult>]()).bind(to: tableView.rx.items(dataSource: dataSource)).addDisposableTo(disposeBag)
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.purple
        label.text = dataSource.sectionModels[section].model
        return label
    }
    
    @IBAction func language(_ sender: UIBarButtonItem) {
        showLocalizeDialog()
    }
    
}
