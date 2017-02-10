import UIKit

class EightViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    var data = ["one","two","three","four","five"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ScrollCell",bundle: nil), forCellReuseIdentifier: "ScrollCell")
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ScrollCell", for: indexPath) as! ScrollCell
        cell.lblTxt.text = data[indexPath.row]
        cell.view1.center = cell.scroll.center
        cell.scroll.isScrollEnabled = true
        cell.isUserInteractionEnabled = true
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    @IBAction func goToRoot(_ sender: Any) {
        if let nav = self.navigationController{
            nav.popToRootViewController(animated: true)
        }
    }
    @IBAction func goBack(_ sender: Any) {
        if let nav = self.navigationController{
            nav.popViewController(animated: true)
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete", handler: { (action, indexPath) in
            tableView.reloadData()
            print("delete Tapped")
        })
        deleteAction.backgroundColor = UIColor.red
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: { (action, indexPath) in
            print("Edit tapped")
            
        })
        editAction.backgroundColor = UIColor.blue
        return [editAction,deleteAction]
    }
}
