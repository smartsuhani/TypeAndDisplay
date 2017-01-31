
import UIKit

class FourthViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    //MARK: - UIOutlets
    @IBOutlet var BtnRoot: UIButton!
    @IBOutlet var BtnBack: UIButton!
    @IBOutlet var tableView: UITableView!
    var jsonDict: NSMutableArray = []
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getfile()
        tableView.register(UINib(nibName: "CellView", bundle: nil), forCellReuseIdentifier: "CellView")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    @IBAction func goToRoot(_ sender: Any) {
        if let nav = self.navigationController {
            nav.popToRootViewController(animated: true)
        }
    }
    @IBAction func goBack(_ sender: Any) {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        }
    }
    
    // MARK: - TableView methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonDict.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellView", for: indexPath) as! CellView
        
        cell.imgView.image = UIImage(named: (jsonDict[indexPath.row] as AnyObject).value(forKey: "image") as! String)
        cell.lblName.text = (jsonDict[indexPath.row] as AnyObject).value(forKey: "name") as? String
        cell.lblSubtitle.text = (jsonDict[indexPath.row] as AnyObject).value(forKey: "age") as? String
        
        return cell
    }
    func getfile(){
        if let filepath = Bundle.main.path(forResource: "1", ofType: "json") {
            do {
                let contents: NSData = try NSData(contentsOfFile: filepath as String, options: NSData.ReadingOptions.dataReadingMapped)
                let dict: NSDictionary!=(try! JSONSerialization.jsonObject(with: contents as Data, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
                
                for i in 0 ..< (dict.value(forKey: "person") as! NSArray).count{
                    jsonDict.add((dict.value(forKey: "person") as! NSArray).object(at: i))
                }
                
                print(jsonDict)
                
            } catch {
                print("Content could not loaded")
            }
        } else {
            print("File Not Found")
        }
    }
}
