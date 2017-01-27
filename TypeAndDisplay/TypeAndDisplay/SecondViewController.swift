import UIKit

class SecondViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    //MARK: UIObject
    @IBOutlet var btn1: UIButton!
    @IBOutlet var txtInput1: UITextField!
    @IBOutlet var table: UITableView!
    @IBOutlet var addBtn: UIButton!
    
    var tablecelltext: [String] = ["kunjal"]
    let cell = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.table.register(UITableViewCell.self, forCellReuseIdentifier: cell)
        
        table.delegate = self
        table.dataSource = self
        
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
        let cell:UITableViewCell = self.table.dequeueReusableCell(withIdentifier: self.cell) as UITableViewCell!
        
        // set the text from the data model
        cell.textLabel?.text = self.tablecelltext[indexPath.row]
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }

}
