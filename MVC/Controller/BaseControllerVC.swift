//
//  BaseControllerVC.swift
//  PowWow
//
//  Created by cbl20 on 7/29/16.
//  Copyright © 2016 Kunal Gupta. All rights reserved.
//

import UIKit

class BaseControllerVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK::- ALERT
    
    func showSnackbar(alert: String){
        let snackbar = MKSnackbar(
            withTitle: alert,
            withDuration: 2.0,
            withTitleColor: UIColor (colorLiteralRed: 1, green: 1, blue: 1, alpha: 1),
            withActionButtonTitle: "",
            withActionButtonColor: UIColor.redColor())
        snackbar.show()

    }
}
