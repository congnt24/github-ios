//
//  LeftViewController.swift
//  GithubDemo
//
//  Created by apple on 5/30/17.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

struct LeftMenuSection {
    var header: String
    var items: [Item]
}

extension LeftMenuSection: SectionModelType {
    typealias Item = String
    init(original: LeftMenuSection, items: [Item]) {
        self.items = items
        self = original
    }
}

class LeftViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var leftMenuSection = [LeftMenuSection]()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        leftMenuSection.append(LeftMenuSection(header: "Personal", items: ["Profile", "Management", "-----"]))
        leftMenuSection.append(LeftMenuSection(header: "Preferences", items: ["Setting", "About", "Signout"]))
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let dataSource = RxTableViewSectionedReloadDataSource<LeftMenuSection>()
        dataSource.configureCell = { ds, tv, ip, item in
            let cell = tv.dequeueReusableCell(withIdentifier: "left_cell")
            cell?.textLabel?.text = item
            return cell!
        }
        dataSource.titleForHeaderInSection = { ds, sectionIndex -> String in
            return self.leftMenuSection[sectionIndex].header
        }
//        tableView.rx.setDelegate(self)
        
        tableView.rx.itemSelected.bind {
            switch $0.section {
            case 0:
                
                break
            default:
                switch $0.row {
                case 0:
                    //setting
                    AppCoordinator.instance.startSetting()
                    break
                case 1:
                    //about
                    break
                default:
                    //singout
                    Token().remove()
                    break
                }
                break
            }
            
            self.slideMenuController()?.closeLeft()

        }.addDisposableTo(disposeBag)
        Observable.just(leftMenuSection).bind(to: tableView.rx.items(dataSource: dataSource)).addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
