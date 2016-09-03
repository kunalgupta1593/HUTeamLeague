//
//  TeamVC.swift
//  TeamLeagueHUTask
//
//  Created by Kunal Gupta on 11/08/16.
//  Copyright © 2016 Kunal Gupta. All rights reserved.
//

import UIKit

class TeamVC: BaseControllerVC,UIGestureRecognizerDelegate {
    
    //MARK::- OUTLETS
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var btnRetry: UIButton!
    
    //MARK::- VARIABLES
    
    var arrNormalTeams = [[String:String]]()
    let arrTabledata = ["Group A","Group B","Group C","Group D","Group E","Group F","Group G","Group H",]
    
    var arrCompleteTeams = [String:NSMutableArray]()
    var tableViewDataSource : TableViewDataSource?
    
    //MARK::- PRE DEFINED
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        startMakingLogic()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK::- SELF MADE
    
    func startMakingLogic(){
        
        arrNormalTeams = []
        var arrChampionTeams = [AnyObject]()
        for i in 0..<ResponseKeys.arrDomesticCountry.count {
            let dictChampionTeam = [
                ResponseEnum.Name.rawValue : ResponseKeys.arrDomesticTeams[i],
                ResponseEnum.Country.rawValue :ResponseKeys.arrDomesticCountry[i],
                ResponseEnum.Image.rawValue :ResponseKeys.arrDomesticImages[i],
                ResponseEnum.Champion.rawValue  :"1"
            ]
            arrChampionTeams.append(dictChampionTeam)
        }
        
        for i in 0..<ResponseKeys.arrTeams.count {
            let dictNormalTeam = [
                ResponseEnum.Name.rawValue : ResponseKeys.arrTeams[i],
                ResponseEnum.Country.rawValue :ResponseKeys.arrCountry[i],
                ResponseEnum.Image.rawValue :ResponseKeys.arrImages[i],
                ResponseEnum.Champion.rawValue  :"0"
            ]
            print(i)
            arrNormalTeams.append(dictNormalTeam)
        }
        
        for i in 0..<ResponseKeys.arrDomesticCountry.count {
            let random = Int(arc4random_uniform(UInt32(arrChampionTeams.count)))
            arrCompleteTeams["\(i)"] = [arrChampionTeams[random]]
            arrChampionTeams.removeAtIndex(random)
            print(arrCompleteTeams)
        }
        
        for i in 0..<ResponseKeys.arrDomesticCountry.count {
            for _ in 0..<3 {
                createTeam(i)
            }
        }
        print(arrCompleteTeams["7"])
        if arrCompleteTeams["7"]?.count < 4 {
            startMakingLogic()
        }
        else{
            confiureTableViewCell()
        }
    }
    
    func createTeam(runningIndex:Int){
        
        let random = Int(arc4random_uniform(UInt32(arrNormalTeams.count)))
        
        if arrNormalTeams.count != 0 {
            var newGroupTeam = arrNormalTeams[random]
            
            if (arrCompleteTeams["\(runningIndex)"]!.filter{ $0["Country"] as? String == newGroupTeam["Country"] }).count == 0 {
                arrCompleteTeams["\(runningIndex)"]?.addObject(newGroupTeam)
                arrNormalTeams.removeAtIndex(random)
            }
            else{
                if runningIndex == 7{
                    startMakingLogic()
                    return
                }
                self.createTeam(runningIndex)
                
            }
        }
    }
    
    //MARK::- CONFIGURE CELL
    
    
    func confiureTableViewCell(){
        weak var weakSelf = self
        tableViewDataSource = TableViewDataSource.init(items: arrTabledata, height: 56, estimatedHeight: 56, tableView: tableView, cellIdentifier: CellIdentifiers.TeamTableCell.rawValue, configureCellBlock: { (cell, item, indexpath) in
            let cell = cell as? TeamCell
            cell?.labelGroup.text = weakSelf?.arrTabledata[indexpath.row]
            }, aRowSelectedListener: { (indexPath) in
                guard let VC = self.storyboard?.instantiateViewControllerWithIdentifier("TeamInfoVC") as? TeamInfoVC else{return}
                let arrModel = self.arrCompleteTeams[String(indexPath.row)]! as NSArray as [AnyObject]
                VC.arrTableData = TeamModel.parseData(arrModel)
                VC.strTitle = weakSelf?.arrTabledata[indexPath.row]
                self.navigationController?.pushViewController(VC, animated: true)
        })
        
        tableView.delegate = tableViewDataSource
        tableView.dataSource = tableViewDataSource
    }
    
    //MARK::- ACTION BUTTON
    
    @IBAction func actionBtnRetry(sender: AnyObject) {
        startMakingLogic()
        super.showSnackbar("List updated successfully!")
     }
}
