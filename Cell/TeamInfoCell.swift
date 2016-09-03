//
//  TeamInfoCell.swift
//  TeamLeagueHUTask
//
//  Created by Kunal Gupta on 11/08/16.
//  Copyright © 2016 Kunal Gupta. All rights reserved.
//

import UIKit

class TeamInfoCell: UITableViewCell {
    
    //MARK::- OUTLETS
    
    @IBOutlet weak var imageViewTeam: UIImageView!
    @IBOutlet weak var labelTeamName: UILabel!
    @IBOutlet weak var labelCountryName: UILabel!
    
    //MARK::- VARIABLES
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK::- SELF MADE
    
    func configureCell(model:TeamModel){
        print(model.strTeamCountry)
        print(model.strTeamName)
        labelTeamName.text = model.strTeamName;
        labelCountryName.text = model.strTeamCountry

        imageViewTeam.image = UIImage(named: model.strImage ?? "");
        
        if model.strIsChampion ?? "" == "1"{
            labelTeamName.textColor = UIColor.redColor()
            labelCountryName.textColor = UIColor.redColor()
        }
        else{
            labelTeamName.textColor = UIColor.blackColor()
            labelCountryName.textColor = UIColor.blackColor()
        }
    }
    
}
