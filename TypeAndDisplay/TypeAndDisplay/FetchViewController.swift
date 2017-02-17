//
//  FetchViewController.swift
//  TypeAndDisplay
//
//  Created by Devloper30 on 15/02/17.
//  Copyright © 2017 lanetteamLanet. All rights reserved.
//

import UIKit

class FetchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var tblView: UITableView!
    var data: [AnyObject]!
    var refresh: UIRefreshControl!
    var task: URLSessionDataTask!
    var task1: URLSessionDownloadTask!
    var session: URLSession!
    var cache: NSCache<AnyObject,AnyObject>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        session = URLSession.shared
        task = URLSessionDataTask()
        task1 = URLSessionDownloadTask()
        
        refresh = UIRefreshControl()
        refresh.backgroundColor = UIColor.clear
        refresh.addTarget(self, action: #selector(self.reloadTable), for: UIControlEvents.valueChanged)
        tblView.refreshControl = refresh
        
        data = []
        cache = NSCache()
        
        tblView.delegate = self
        tblView.dataSource = self
        tblView.register(UINib(nibName: "CellController",bundle: nil), forCellReuseIdentifier: "CellController")
        
    }

    func reloadTable(){
        let url:URL! = URL(string: "http://127.0.0.1:8085/mongoose/fetchall")
        task = session.dataTask(with: url, completionHandler: { (location: Data?, response: URLResponse?, error: Error?) -> Void in
            if location != nil{
                let data:Data! = location!
                do{
                    let dic = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as AnyObject
                    print(dic)
                    self.data = dic.value(forKey : "user") as? [AnyObject]
                    DispatchQueue.main.async(execute: { () -> Void in
                        self.tblView.reloadData()
                        self.refresh?.endRefreshing()
                    })
                }catch{
                    print("something went wrong, try again")
                }
            }
        })
        task.resume()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellController", for: indexPath) as! CellController
        let dictionary = self.data[(indexPath as NSIndexPath).row] as! [String:AnyObject]
        cell.textLabel!.text = dictionary["username"] as? String
        cell.imageView?.image = UIImage(named: "placeholder")
        
        if (self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) != nil){
            // 2
            // Use cache
            print("Cached image used, no need to download it")
            cell.imageView?.image = self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) as? UIImage
        }else{
            // 3
            let artworkUrl = dictionary["artworkUrl100"] as! String
            let url:URL! = URL(string: artworkUrl)
            task1 = session.downloadTask(with: url, completionHandler: { (location, response, error) -> Void in
                if let data = try? Data(contentsOf: url){
                    // 4
                    DispatchQueue.main.async(execute: { () -> Void in
                        // 5
                        // Before we assign the image, check whether the current cell is visible
                        if let updateCell = tableView.cellForRow(at: indexPath) {
                            let img:UIImage! = UIImage(data: data)
                            updateCell.imageView?.image = img
                            self.cache.setObject(img, forKey: (indexPath as NSIndexPath).row as AnyObject)
                        }
                    })
                }
            })
            task.resume()
        }
        return cell
    }

}
