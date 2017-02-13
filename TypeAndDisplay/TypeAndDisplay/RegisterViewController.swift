import UIKit
import CoreData

class RegisterViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtUsername: UITextField!

    @IBOutlet var table: UITableView!
    @IBOutlet var BtnAdd: UIButton!
    var fetchedPerson: [User] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        table.delegate = self
        table.dataSource = self
        table.register(UINib(nibName: "CellView", bundle: nil), forCellReuseIdentifier: "CellView")

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
        cell.imgView.image = UIImage(named: "Google")
        cell.lblName.text = fetchedPerson[indexPath.row].name
        cell.lblSubtitle.text = fetchedPerson[indexPath.row].username
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedPerson.count
    }
    
    func Saveperson(){
        let data = DataController().managedObjectContext
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
        fetch()
    }
    
    @IBAction func saveUser(_ sender: Any) {
        Saveperson()
    }
    func fetch() {
        let moc = DataController().managedObjectContext
        let personFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        do {
            fetchedPerson = try moc.fetch(personFetch) as! [User]
            print(fetchedPerson)
            
        } catch {
            fatalError("Failed to fetch User: \(error)")
        }
        table.reloadData()
    }
    
}
