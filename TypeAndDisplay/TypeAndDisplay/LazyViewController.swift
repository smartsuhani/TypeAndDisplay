import UIKit

class LazyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var tblView: UITableView!
    var dataDict: [AnyObject]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataDict = []
        
        connect("http://127.0.0.1:8087/mongoose/fetchall")
        
        tblView.delegate = self
        tblView.dataSource = self
        tblView.register(UINib(nibName:"CellController",bundle: nil), forCellReuseIdentifier: "CellController")
        
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "CellController", for: indexPath) as! CellController
        let dictionary = self.dataDict[indexPath.row] as! [String:AnyObject]
        cell.t1.text = "Name: "
        cell.t1.text!.append((dictionary["fullname"] as? String)!)
        cell.t2.text = "Username: "
        cell.t2.text!.append((dictionary["username"] as? String)!)
        cell.t3.text = "Email Id: "
        cell.t3.text!.append((dictionary["email_id"] as? String)!)
        cell.t4.text = "User Id: "
        cell.t4.text!.append((dictionary["user_id"] as? String)!)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func connect(_ url1:String){
        let url = URL(string: url1)
        let session = URLSession.shared
        
        let req = NSMutableURLRequest(url: url!)
        req.httpMethod = "GET"
        req.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let task = session.dataTask(with: req as URLRequest) {
            (data, response, error) in
            
            guard let _:NSData = data as NSData?, let _:URLResponse = response, error == nil else {
                print("error")
                return
            }
            
            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print(dataString!)
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as AnyObject
                self.dataDict = json.value(forKey: "user") as? [AnyObject]
                DispatchQueue.main.async(execute: { () -> Void in
                    self.tblView.reloadData()
                })
            }catch{
                print("Error")
            }
        }
        task.resume()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataDict.count
    }
    @IBAction func reg(_ sender: Any) {
        let alert = UIAlertController(title: "Register", message: "Enter Details", preferredStyle: .alert)
        let action = UIAlertAction(title: "Register", style: .default) { (action) in
            let firstname = alert.textFields![0] as UITextField
            let lastname = alert.textFields![1] as UITextField
            let username = alert.textFields![2] as UITextField
            let email_id = alert.textFields![3] as UITextField
            let password = alert.textFields![4] as UITextField
            
            let parameters = ["firstname":firstname.text!, "lastname":lastname.text!,"username":username.text!,"email_id":email_id.text!,"password":password.text!] as Dictionary<String, String>
            let request = NSMutableURLRequest(url: NSURL(string: "http://127.0.0.1:8087/mongo/reg")! as URL)
            
            let session = URLSession.shared
            request.httpMethod = "POST"
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
            
            let task = session.dataTask(with: request as URLRequest) { data, response, error in
                guard data != nil else {
                    print("no data found: \(error)")
                    return
                }
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                        print("Response: \(json)")
                    } else {
                        let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                        print("Error could not parse JSON: \(jsonStr)")
                    }
                } catch let parseError {
                    print(parseError)
                    let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    print("Error could not parse JSON: '\(jsonStr)'")
                }
            }
            self.tblView.reloadData()
            task.resume()
        }
        let action2 = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter First Name"
        }
        alert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Last Name"
        }
        alert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter username"
        }
        alert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Email ID"
        }
        alert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter password"
        }
        
        alert.addAction(action)
        alert.addAction(action2)
        
        self.present(alert,animated: true,completion: nil)
    }
    
    
}
