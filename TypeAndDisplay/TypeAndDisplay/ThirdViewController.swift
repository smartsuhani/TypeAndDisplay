//
//  ThirdViewController.swift
//  TypeAndDisplay
//
//  Created by Devloper30 on 25/01/17.
//  Copyright © 2017 lanetteamLanet. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet var backbtn: UIButton!
    @IBOutlet var rootbtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func gotoroot(_ sender: UIButton) {
        if let nav = self.navigationController {
            nav.popToRootViewController(animated: true)
        }
    }
    @IBAction func back(_ sender: UIButton) {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
