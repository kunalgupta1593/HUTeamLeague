
//
//  TeamModel.swift
//  TeamLeagueHUTask
//
//  Created by Kunal Gupta on 11/08/16.
//  Copyright © 2016 Kunal Gupta. All rights reserved.
//

import UIKit

class TeamModel: NSObject {

    var strTeamName: String?
    var strTeamCountry: String?
    var strImage: String?
    var strIsChampion : String?

    
    init(dict : [String:String]) {
        super.init()
        print(dict)
        strTeamName = dict[ResponseEnum.Name.rawValue] ?? ""
        strTeamCountry = dict[ResponseEnum.Country.rawValue] ?? ""
        strImage = dict[ResponseEnum.Image.rawValue] ?? ""
        strIsChampion = dict[ResponseEnum.Champion.rawValue] ?? ""

    }
    
    override init() {
        super.init()
    }
    
    
    static func parseData(array: [AnyObject]) -> ([TeamModel]){
        var tempArr : [TeamModel] = []
        for dict in array {
            print(dict)
            let placeValues = TeamModel(dict: dict as? [String:String] ?? [:])
             tempArr.append(placeValues)
            
        }
        return tempArr
    }

}
