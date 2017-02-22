import UIKit
import UserNotifications

class SecondViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {

    //MARK: UIObject
    @IBOutlet var btn1: UIButton!
    @IBOutlet var txtInput2: UITextField!
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
    var view1: UIView!
    var picker1: [String] = ["1","2","3","4","5"]
    var picker2: [String] = ["A","B","C","D","E"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pickerView = UIPickerView()
        pickerView.delegate = self
        txtInput2.inputView = pickerView
        view1 = UIView(frame: CGRect(x:0,y:450,width:self.view.frame.width+80,height:70))
        self.view.addSubview(view1)
        let lbl = UILabel()
        lbl.frame = CGRect(x:0,y:20,width:100,height:50)
        lbl.text = "Welcome"
        lbl.textColor = UIColor.black
        view1.addSubview(lbl)
        
        
        UIView.beginAnimations("op", context: nil)
        UIView.setAnimationDuration(5)
        UIView.setAnimationCurve(UIViewAnimationCurve.easeIn)
            print(self.view.center)
            lbl.center.x = self.view.center.x + 50
            let scale = CGAffineTransform(scaleX: 2, y: 2)
            lbl.transform = scale
            lbl.textColor = UIColor.blue

        UIView.commitAnimations()
        
        UIView.beginAnimations("op1", context: nil)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationDidStop(#selector(self.r))
        UIView.setAnimationBeginsFromCurrentState(true)

        UIView.setAnimationDuration(8)
        UIView.setAnimationCurve(UIViewAnimationCurve.easeIn)
        lbl.textColor = UIColor.red
        lbl.textColor = UIColor.green
        lbl.alpha = 0
        UIView.commitAnimations()
        
        
        // Do any additional setup after loading the view.
        refresh = UIRefreshControl()
        print(self.nibName!)
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
        navigationController?.navigationBar.isHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(FourthViewController.editButtonPressed))
    }
    
    func r(){
        print("adloa")
                self.view1.removeFromSuperview()
    }

    
    func editButtonPressed(){
        table.setEditing(!table.isEditing, animated: true)
        if table.isEditing == true{
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(FourthViewController.editButtonPressed))
        }else{
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(FourthViewController.editButtonPressed))
        }
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
            self.notify(tablecelltext.count - 1)
        }
    }
    
    @IBAction func deleteCell(_ sender: UIButton) {
        let alert = UIAlertController(title: "Confirm Delete", message: "Your Image", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "no", style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(UIAlertAction(title: "yes", style: UIAlertActionStyle.destructive, handler: { (UIAlertAction) in
            self.del()
        }))
        self.present(alert, animated: true)
    }
    
    func del(){
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
        table.reloadData()
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
    
    // MARK: - Navigation

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
        cell.imgBarcode.image = cell.fromString(string: self.tablecelltext[indexPath.row])
        cell.imgView.image = UIImage(named: "Google")
        
        return cell
    }
    func tapped(){
        print("tapped")
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
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = tablecelltext[sourceIndexPath.row]
        tablecelltext.remove(at: sourceIndexPath.row)
        tablecelltext.insert(itemToMove, at: destinationIndexPath.row)
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
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == 0){
            return picker1.count
        }else{
            return picker2.count
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(component == 0){
            return picker1[row]
        }else{
            return picker2[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      txtInput2.text = "\(picker1[pickerView.selectedRow(inComponent: 0)])/\(picker2[pickerView.selectedRow(inComponent: 1)])"
    }
    
    func notify(_ indexPath: Int){
        let notify = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert,.sound]
        
        notify.requestAuthorization(options: options) { (granted,error) in
            if !granted {
                print("somting wrong happening!")
            }
        }
        
        notify.getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized {
                print("app is not authorized to generate notification!")
            }else{
                
            }
        }
        
        
        let noteContent = UNMutableNotificationContent()
        noteContent.title = "User Added"
        noteContent.body = self.tablecelltext[indexPath]
        noteContent.sound = UNNotificationSound.default()
        noteContent.setValue(true, forKey: "shouldAlwaysAlertWhileAppIsForeground")
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2.0, repeats: false)
        
        let identifier = "UserAddedNotificaion"
        let req = UNNotificationRequest(identifier: identifier, content: noteContent, trigger: trigger)
        
        notify.add(req) { (error) in
            if let err = error {
                print("\(err)error in notification generation!")
            }
        }
    }
}
