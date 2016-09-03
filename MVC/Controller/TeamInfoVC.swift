//
//  TeamInfoVC.swift
//  TeamLeagueHUTask
//
//  Created by Kunal Gupta on 11/08/16.
//  Copyright © 2016 Kunal Gupta. All rights reserved.
//

import UIKit

class TeamInfoVC: UIViewController {

    //MARK::- OUTLETS

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelTitle: UILabel!
    
    //MARK::- VARIABLES

    var index : NSIndexPath?
    var arrTableData : [TeamModel]?
    var tableViewDataSource : TableViewDataSource?
    var newArray = [AnyObject]()
    var strTitle : String?
    
    //MARK::- PREDEFINED METHODS

    override func viewDidLoad() {
        super.viewDidLoad()
        initialise()
    }
    
    
    //MARK::- SELF MADE
    
    func initialise(){
        labelTitle.text = strTitle
        confiureTableViewCell()
    }

    func confiureTableViewCell(){
        
        tableViewDataSource = TableViewDataSource.init(items: arrTableData , height: 56, estimatedHeight: 56, tableView: tableView, cellIdentifier: CellIdentifiers.TeamInfoTableCell.rawValue, configureCellBlock: { (cell, item, indexpath) in
            let cell = cell as? TeamInfoCell
            print(item)
            var arr = [TeamModel]()
            arr = item as? [TeamModel] ?? []
            let itemModal = arr[indexpath.row]
            cell?.configureCell(itemModal)
            }, aRowSelectedListener: { (indexPath) in

        })
        
        tableView.delegate = tableViewDataSource
        tableView.dataSource = tableViewDataSource
    }
    //MARK::- ACTION BUTTON
    
    @IBAction func actionBtnBack(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }

}
