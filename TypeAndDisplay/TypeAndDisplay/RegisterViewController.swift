import UIKit
import CoreData

class RegisterViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating {

    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtUsername: UITextField!

    @IBOutlet var BtnUpdate: UIButton!
    @IBOutlet var table: UITableView!
    @IBOutlet var BtnAdd: UIButton!
    let moc = DataController()
    var fetchedPerson: [User] = []
    var filteredArray = [User]()
    var shouldShowSearchResults = false
    var updatePath: IndexPath!
    
    var searchController: UISearchController!
    
    var usersFromCoreData: [NSManagedObject] {
        get {
            
            var resultArray:Array<NSManagedObject>!
            let managedContext = moc.managedObjectContext
            let fetchRequest =
                NSFetchRequest<NSManagedObject>(entityName: "User")
            
            do {
                resultArray = try managedContext.fetch(fetchRequest)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
            
            return resultArray
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        
        table.delegate = self
        table.dataSource = self
        table.register(UINib(nibName: "CellView", bundle: nil), forCellReuseIdentifier: "CellView")
        fetch()
        
        BtnUpdate.isHidden = true

    }
    
    func configureSearchController() {
        // Initialize and perform a minimum configuration to the search controller.
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search here..."
        searchController.searchBar.sizeToFit()
        
        // Place the search bar view to the tableview headerview.
        table.tableHeaderView = searchController.searchBar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lblTitle.alpha = 0
        let t1 = txtName.frame.origin.x
        let t2 = txtPassword.frame.origin.x
        let t3 = txtUsername.frame.origin.x
        txtUsername.frame.origin.x = self.view.frame.width
        txtName.frame.origin.x = -self.view.frame.width
        txtPassword.frame.origin.x = -self.view.frame.width
        
        let tbl = table.frame.origin.y
        table.frame.origin.y = self.view.frame.height
        let frame = BtnAdd.frame
        UIView.animate(withDuration: 5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveLinear, animations: {
            self.lblTitle.alpha = 1
            self.txtUsername.frame.origin.x = t3
            self.txtName.frame.origin.x = t1
            self.txtPassword.frame.origin.x = t2
            self.table.frame.origin.y = tbl
            self.BtnAdd.layer.cornerRadius = frame.height/2 - 5
        }, completion: nil)

        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "CellView", for: indexPath) as! CellView
        
        if (self.searchController.isActive) {
            cell.imgView.image = UIImage(named: "Google")
            cell.lblName.text = filteredArray[indexPath.row].name
            cell.lblSubtitle.text = filteredArray[indexPath.row].password
        }else{
            cell.imgView.image = UIImage(named: "Google")
            cell.lblName.text = fetchedPerson[indexPath.row].name
            cell.lblSubtitle.text = fetchedPerson[indexPath.row].password
        }
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.searchController.isActive) {
            return filteredArray.count
        }else{
            return fetchedPerson.count
        }
        
    }
    
    func Saveperson(){
        let data = moc.managedObjectContext
        let entity = NSEntityDescription.insertNewObject(forEntityName: "User", into: data) as! User
        
        entity.setValue(txtName.text!, forKey: "name")
        entity.setValue(txtUsername.text!, forKey: "username")
        entity.setValue(txtPassword.text!, forKey: "password")
        
        // we save our entity
        do {
            try data.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    @IBAction func saveUser(_ sender: Any) {
        Saveperson()
    }

    func fetch() {
        fetchedPerson = self.usersFromCoreData as! [User]
        table.reloadData()
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "delete") { (action, indexPath) in
            print("delete tapped")
            let ob = self.usersFromCoreData[indexPath.row] as! User
            print(ob.name!)
            self.moc.managedObjectContext.delete(ob)
            
            self.fetchedPerson.remove(at: indexPath.row)
            do{
                try self.moc.managedObjectContext.save()
            }catch{
            
            }
            self.fetch()
        }
        delete.backgroundColor = UIColor.red
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            print("edit tapped")
            self.txtName.text = self.fetchedPerson[indexPath.row].name
            self.txtUsername.text = self.fetchedPerson[indexPath.row].username
            self.txtPassword.text = self.fetchedPerson[indexPath.row].password
            
            self.BtnAdd.isHidden = true
            self.updatePath = indexPath
            self.BtnUpdate.isHidden = false
        }
        edit.backgroundColor = UIColor.green
        return [delete,edit]
    }
    
    @IBAction func updateData(_ sender: Any) {
        fetchedPerson[updatePath.row].name = txtName.text!
        fetchedPerson[updatePath.row].username = txtUsername.text!
        fetchedPerson[updatePath.row].password = txtPassword.text!
        
        do{
            try moc.managedObjectContext.s
        }catch{
        
        }
    }
    func updateSearchResults(for searchController: UISearchController) {
        filteredArray.removeAll(keepingCapacity: false)
        let array: NSArray = self.usersFromCoreData as NSArray
        let predicate = NSPredicate(format: "name contains[c] %@ OR password contains[c] %@ OR username contains[c] %@",searchController.searchBar.text!,searchController.searchBar.text!,searchController.searchBar.text!)
        
        filteredArray = array.filtered(using: predicate) as! [User]
        print(filteredArray)
        self.table.reloadData()
    }
    
}
