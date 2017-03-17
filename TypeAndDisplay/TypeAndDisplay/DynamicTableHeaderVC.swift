//
//  DynamicTableHeaderVC.swift
//  TypeAndDisplay
//
//  Created by Devloper30 on 17/03/17.
//  Copyright © 2017 lanetteamLanet. All rights reserved.
//

import UIKit

class DynamicTableHeaderVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var DataView: UIView!
    @IBOutlet var tblSliders: UITableView!
    @IBOutlet var txfRow: UITextField!
    @IBOutlet var txfSection: UITextField!
    var sections = [[Float]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        DataView.frame = CGRect(x: (self.view.frame.width/2)-(DataView.frame.width/2), y: (self.view.frame.height/2)-(DataView.frame.height/2), width: DataView.frame.width, height: DataView.frame.height)
        DataView.layer.borderWidth = 2
        DataView.layer.borderColor = UIColor.black.cgColor
        DataView.backgroundColor = UIColor.lightGray
        self.view.addSubview(DataView)
        tblSliders.delegate = self
        tblSliders.dataSource = self
        tblSliders.register(UINib(nibName: "DTHCellTableViewCell", bundle: nil), forCellReuseIdentifier: "DTHCellTableViewCell")
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view2 = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 70))
        let view1 = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 20))
        view1.layer.cornerRadius = 10
        let view = UIView(frame: CGRect(x: 0, y: 10, width: tableView.frame.width, height: 60))
        let lbl = UILabel(frame: CGRect(x: view.frame.width/2 - 50, y: view.frame.height/2 - 15, width: 100, height: 30))
        lbl.text = "Section \(section)"
        view2.addSubview(view1)
        view2.addSubview(view)
        view2.addSubview(lbl)
        var avg: Float = 0
        var a: Float = 0
        for i in (sections[section]) {
            avg += i
            a += 1
        }
        
        avg = avg / a
        if avg <= 3.33 && avg > 0{
            view.backgroundColor = UIColor.green
            view1.backgroundColor = UIColor.green
        } else if avg > 3.33 && avg <= 6.66 {
            view.backgroundColor = UIColor.red
            view1.backgroundColor = UIColor.red
        } else if avg > 6.66 {
            view.backgroundColor = UIColor.cyan
            view1.backgroundColor = UIColor.cyan
        }
        return view2
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view1 = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 20))
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 55))
        view.layer.cornerRadius = 10
        var avg: Float = 0
        var a: Float = 0
        for i in (sections[section]) {
            avg += i
            a += 1
        }
        
        avg = avg / a
        if avg <= 3.33 && avg > 0{
            view.backgroundColor = UIColor.green
            view1.backgroundColor = UIColor.green
        } else if avg > 3.33 && avg <= 6.66 {
            view.backgroundColor = UIColor.red
            view1.backgroundColor = UIColor.red
        } else if avg > 6.66 {
            view.backgroundColor = UIColor.cyan
            view1.backgroundColor = UIColor.cyan
        }
        view.addSubview(view1)
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DTHCellTableViewCell", for: indexPath) as! DTHCellTableViewCell
        cell.vc = self
        cell.indexPath = indexPath
        _ = sections[indexPath.section]
        cell.Lbltitle.text = String(describing: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 55
    }
    @IBAction func handleGetData(_ sender: Any) {
        DataView.removeFromSuperview()
        let sec = Int(txfSection.text!)
        let row = Int(txfRow.text!)
        
        for _ in 0 ..< sec! {
            var a: [Float] = []
            for _ in 0 ..< row! {
                a.append(0)
            }
            sections.append(a)
        }
        tblSliders.reloadData()
    }

}
