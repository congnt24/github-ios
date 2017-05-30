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
    //MARK: - Variable
    var uiRefresh = UIRefreshControl()
    var viewModel: HomeViewModel!
    let disposeBag = DisposeBag()
    var repo = PublishSubject<[SectionModel<String, RepoResult>]>()
    var repos = Variable<[SectionModel<String, RepoResult>]>([])
    
    var dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, RepoResult>>()
    //MARK: - functions
    override func viewDidLoad() {
        //Register table cell
        tableView.register(UINib(nibName: "RepoTableViewCell", bundle: nil), forCellReuseIdentifier: "homecell2")
        tableView.register(UINib(nibName: "EmptyTableViewCell", bundle: nil), forCellReuseIdentifier: "empty_cell")
        
        
        uiRefresh.attributedTitle = NSAttributedString(string: "Pull to refresh")
        uiRefresh.addTarget(self, action: #selector(refresh(sender:)), for: UIControlEvents.valueChanged)
        tableView.addSubview(uiRefresh)
        setupRx()
        
        title = "hello".localized()
        
        addLeftBarButtonWithImage(R.image.icons8Search_filled()!)
        // A little trick for removing the cell separators
        self.tableView.tableFooterView = UIView()
        
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
                //if request success but return empty, emit an no data item
                
                //use for load more
                self.repos.value.append(SectionModel(model: "header", items: repos.repos))
                //use for reload
                self.repo.onNext([SectionModel(model: "header", items: repos.repos)])
                break
            case .error(_):
                    //show error
//                self.repo.onError(GithubError.generic)
//                if self.repos.value.count == 0 {
//                    self.repos.value.append(SectionModel<String, RepoResult>(model: "empty", items: [RepoResult]()))
//                }
                
                self.repo.onNext([SectionModel<String, RepoResult>](repeating: SectionModel(model: "empty", items: [RepoResult]()), count: 1))
                break
            }
        }).addDisposableTo(disposeBag)
        
        
        tableView.rx.setDelegate(self).addDisposableTo(disposeBag)
        dataSource.configureCell = { ds /*datasource*/, tv /*tableView*/,ip ,item in
            let cell = tv.dequeueReusableCell(withIdentifier: "homecell2") as! RepoTableViewCell
            cell.title.text = item.name
            cell.desc.text = item.description
            return cell
        }
        
        dataSource.titleForHeaderInSection = { dataSource, sectionIndex in
            return dataSource[sectionIndex].model
        }
//
//        dataSource._rx_tableView(tableView, titleForHeaderInSection: 0)
        
        repo.asObserver().catchErrorJustReturn([SectionModel<String, RepoResult>]()).bind(to: tableView.rx.items(dataSource: dataSource)).addDisposableTo(disposeBag)
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if dataSource.sectionModels[section].model == "empty" {
            let headerView = UIView()
//            headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.frame.height)
            //don't need reuseable
//            let cell = tableView.dequeueReusableCell(withIdentifier: "empty_cell") as! EmptyTableViewCell
            let cell = UINib(nibName: "EmptyTableViewCell", bundle: nil).instantiate(withOwner: nil, options: nil).first as! UIView
            headerView.addSubview(cell)
            return headerView
        }
        
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
