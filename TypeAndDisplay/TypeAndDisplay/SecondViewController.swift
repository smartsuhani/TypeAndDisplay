import UIKit

class SecondViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {

    //MARK: UIObject
    @IBOutlet var btn1: UIButton!
    @IBOutlet var txtInput1: UITextField!
    @IBOutlet var table: UITableView!
    @IBOutlet var addBtn: UIButton!
    @IBOutlet var delete: UIButton!
    @IBOutlet var switch1: UISwitch!
    @IBOutlet var updateBtn: UIButton!
    var refresh: UIRefreshControl!
    var timer: Timer!
    
    var tablecelltext: [String] = ["Google"]
    let cell = "cell"
    var selected: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        refresh = UIRefreshControl()
        
        refresh.backgroundColor = UIColor.cyan
        table.addSubview(refresh)
        refresh.addTarget(self, action: #selector(self.reload1(_:)), for: UIControlEvents.valueChanged)
        
        table.register(UINib(nibName: "CellView",bundle: nil), forCellReuseIdentifier: "CellView")
        
        table.delegate = self
        table.dataSource = self
        txtInput1.delegate = self
        
        if(switch1.isOn){
            table.allowsMultipleSelection = true
        }else{
            table.allowsMultipleSelection = false
        }
        //getfile()
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtInput1.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(selected != nil){
        tablecelltext[selected!] = txtInput1.text!
        selected = nil
        //table.reloadData()
        }
    }
    func reload1(_ sender: AnyObject?){
//        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(SecondViewController.refresh1(_:)), userInfo: nil, repeats: true)
        table.reloadData()
        refresh.endRefreshing()
    }
    func refresh1(_ sender: AnyObject){
        table.reloadData()
        refresh.endRefreshing()
    }
    //MARK: UIObjectActions
    
    @IBAction func change(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        nextViewController.mystring = txtInput1.text
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    // MARK: Actions
    
    @IBAction func addToTable(_ sender: UIButton) {
        if(txtInput1.text != ""){
            tablecelltext.append(txtInput1.text!)
            print(tablecelltext)
            table.reloadData()
        }
    }
    
    @IBAction func deleteCell(_ sender: UIButton) {
        if(tablecelltext.count != 0){
            if txtInput1.text != "" && ((table.indexPathsForSelectedRows)?.count ?? 0) < 2 {
                if(tablecelltext.contains(txtInput1.text!)){
                    let a = tablecelltext.count
                    for _ in (0...a){
                        if(tablecelltext.contains(txtInput1.text!))
                        {
                            print(txtInput1.text!)
                            tablecelltext.remove(at: tablecelltext.index(of: txtInput1.text!)!)
                        }
                    }
                }
            }else{
                if let indexPaths = table.indexPathsForSelectedRows  {
                
                    let sortedArray = indexPaths.sorted {$0.row < $1.row}
                
                    for i in (0...sortedArray.count-1).reversed() {
                    
                        tablecelltext.remove(at: sortedArray[i].row)
                    }
                    table.deleteRows(at: sortedArray, with: .automatic)
                
                }
            }
        }else{
            print("table ma kai nathi")
        }
        //table.reloadData()
    }
    
    @IBAction func changeOption(_ sender: UISwitch) {
        if table.allowsMultipleSelection == true {
            table.allowsMultipleSelection = false
        }else{
            table.allowsMultipleSelection = true
        }
    }
    @IBAction func updateTable(_ sender: UIButton) {
        update();
    }
    func update(){
        if (table.indexPathsForSelectedRows?.count) ?? 0 > 0 {
            if txtInput1.text != "" {
                if let indexPaths = table.indexPathsForSelectedRows  {
                    
                    let sortedArray = indexPaths.sorted {$0.row < $1.row}
                    
                    for i in (0...sortedArray.count-1).reversed() {
                        
                        tablecelltext[sortedArray[i].row] = txtInput1.text!
                    }
                    
                }
            }
        }else if((table.indexPathForSelectedRow?.item) ?? -1 > -1){
            if txtInput1.text != "" {
                tablecelltext[(table.indexPathForSelectedRow?.item)!] = txtInput1.text!
            }
        }else if((table.indexPathForSelectedRow?.item) ?? -1 == -1 && selected != nil){
            tablecelltext[selected!] = txtInput1.text!
            selected = nil
        }else{
            print("no item selected")
        }
        //table.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tablecelltext.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell = table.dequeueReusableCell(withIdentifier: "CellView", for: indexPath) as! CellView
        
        // set the text from the data model
        
        cell.lblName.text = self.tablecelltext[indexPath.row]
        cell.lblSubtitle.text = "Name of Person"
        cell.imgView.image = UIImage(named: "Google")
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete", handler: { (action, indexPath) in
            print("Delete tapped")
            self.tablecelltext.remove(at: indexPath.item)
            tableView.reloadData()
            
        })
        deleteAction.backgroundColor = UIColor.red
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: { (action, indexPath) in
            self.txtInput1.text = self.tablecelltext[indexPath.item]
            self.txtInput1.setNeedsFocusUpdate()
            self.selected = indexPath.item
            print("Edit tapped")
            
        })
        editAction.backgroundColor = UIColor.blue
        return [editAction,deleteAction]
    }
    func getfile(){
        if let filepath = Bundle.main.path(forResource: "1", ofType: "json") {
            do {
                let contents = try String(contentsOfFile: filepath)
                print(contents)
            } catch {
                print("Content could not loaded")
            }
        } else {
                print("File Not Found")
        }
    }
}
