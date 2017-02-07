
import UIKit

class FourthViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {
    
    //MARK: - UIOutlets
    @IBOutlet var BtnRoot: UIButton!
    @IBOutlet var BtnBack: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var BtnNext: UIButton!
    var jsonDict: NSMutableArray = []
    var section1 = ["10-19","20-29","30-35"]
    var age1: [[String]] = [[],[],[]] //[[section1],[section2],[section3]]
    var ukey:[[Int]] = [[],[],[]]
    var tbl: UITableViewController!
    let path = "/Users/itilak/Desktop/TypeAndDisplay/TypeAndDisplay/TypeAndDisplay/1.json"
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tbl = UITableViewController()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        tableView.delegate = self
        tableView.dataSource = self
        getfile()
        tableView.register(UINib(nibName: "CellView", bundle: nil), forCellReuseIdentifier: "CellView")
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(FourthViewController.editButtonPressed))
    }
    
    func editButtonPressed(){
        tableView.setEditing(!tableView.isEditing, animated: true)
        if tableView.isEditing == true{
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(FourthViewController.editButtonPressed))
        }else{
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(FourthViewController.editButtonPressed))
        }
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
   
    @IBAction func goToNext(_ sender: Any) {
        self.navigationController?.pushViewController(FifthViewController(), animated: true)
    }
    
    // MARK: - TableView methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return age1[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellView", for: indexPath) as! CellView
        
        cell.imgView.image = UIImage(named: ((jsonDict[indexPath.row] as AnyObject).value(forKey: "image") as? String)!)
        cell.lblName.text = (jsonDict[indexPath.row] as AnyObject).value(forKey: "name") as? String
        cell.lblSubtitle.text = age1[indexPath.section][indexPath.row]
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return section1.count
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "Delete", handler: { (action, indexPath) in
            print("delete trapped")
            
            var key = self.ukey[indexPath.section].remove(at: indexPath.row)
            self.age1[indexPath.section].remove(at: indexPath.row)
            for i in 0 ..< self.jsonDict.count{
                let data = (self.jsonDict[i] as AnyObject).value(forKey: "key") as? Int
                if(data == key){
                    key = i
                    break
                }
            }
            
            self.jsonDict.removeObject(at: key)
            self.tableView.reloadData()
            self.updateFile()
        })
        return [delete]
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = age1[sourceIndexPath.section][sourceIndexPath.row]
        print("\(item)ahbkinadinaifwbai")
        age1[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        age1[destinationIndexPath.section].insert(item, at: destinationIndexPath.row)
        
        print(age1)
        tableView.reloadData()
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section1[section]
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func getfile(){
        
            do {
                let contents: NSData = try NSData(contentsOfFile: path as String, options: NSData.ReadingOptions.dataReadingMapped)
                let dict: NSDictionary!=(try! JSONSerialization.jsonObject(with: contents as Data, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
                
                for i in 0 ..< (dict.value(forKey: "person") as! NSArray).count{
                    jsonDict.add((dict.value(forKey: "person") as! NSArray).object(at: i))
                    let age = Int(((jsonDict[i] as AnyObject).value(forKey: "age") as? String)!)!
                    if(age >= 10 && age<20){
                        age1[0].append(((jsonDict[i] as AnyObject).value(forKey: "age") as? String)!)
                        ukey[0].append(((jsonDict[i] as AnyObject).value(forKey: "key") as? Int)!)
                    }else if(age >= 20 && age<30){
                        age1[1].append(((jsonDict[i] as AnyObject).value(forKey: "age") as? String)!)
                        ukey[1].append(((jsonDict[i] as AnyObject).value(forKey: "key") as? Int)!)
                    }else{
                        age1[2].append(((jsonDict[i] as AnyObject).value(forKey: "age") as? String)!)
                        ukey[2].append(((jsonDict[i] as AnyObject).value(forKey: "key") as? Int)!)
                    }
                }
                
                
            } catch {
                print("Content could not loaded")
            }
        
    }
    func updateFile() {
        print("FilePath: \(path)")
        
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: jsonDict, options: JSONSerialization.WritingOptions.prettyPrinted)
            let convertedString = String(data: data1, encoding: String.Encoding.utf8)
            print("NewData\(convertedString!)NewData")
            let text = "{\n\t\"person\":"+convertedString!+"\n}"
            
            // Write to the file
            try text.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("Failed writing to URL: \(path), Error: " + error.localizedDescription)
        }
        
        do {
            let contents: NSData = try NSData(contentsOfFile: path as String, options: NSData.ReadingOptions.dataReadingMapped)
            print(NSString(data: contents as Data, encoding: String.Encoding.utf8.rawValue) as String!)
        }catch{
            print("data not available")
        }
    }
    
}
