
import UIKit

class FourthViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //MARK: - UIOutlets
    @IBOutlet var BtnRoot: UIButton!
    @IBOutlet var BtnBack: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var BtnNext: UIButton!
    var jsonDict: NSMutableArray = []
    var section1 = ["10-19","20-29","30-35"]
    var age1: [[String]] = [[],[],[]] //[[section1],[section2],[section3]]
    var tbl: UITableViewController!
    
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
        })
        return [delete]
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section1[section]
    }
    func getfile(){
        if let filepath = Bundle.main.path(forResource: "1", ofType: "json") {
            do {
                let contents: NSData = try NSData(contentsOfFile: filepath as String, options: NSData.ReadingOptions.dataReadingMapped)
                let dict: NSDictionary!=(try! JSONSerialization.jsonObject(with: contents as Data, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
                
                for i in 0 ..< (dict.value(forKey: "person") as! NSArray).count{
                    jsonDict.add((dict.value(forKey: "person") as! NSArray).object(at: i))
                    let age = Int(((jsonDict[i] as AnyObject).value(forKey: "age") as? String)!)!
                    if(age >= 10 && age<20){
                        age1[0].append(((jsonDict[i] as AnyObject).value(forKey: "age") as? String)!)
                    }else if(age >= 20 && age<30){
                        age1[1].append(((jsonDict[i] as AnyObject).value(forKey: "age") as? String)!)
                    }else{
                        age1[2].append(((jsonDict[i] as AnyObject).value(forKey: "age") as? String)!)
                    }
                }
                
                print(jsonDict)
                
            } catch {
                print("Content could not loaded")
            }
        } else {
            print("File Not Found")
        }
        
    }
    func updateFile() {
        
    }
    
}
