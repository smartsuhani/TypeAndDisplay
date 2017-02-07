import UIKit

class MasterViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
   // var secondryViewController = UIViewController()
    var viewContollers: [UIViewController]! = [SecondViewController(),ThirdViewController(),FourthViewController(),SixViewController(),MapViewController()]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "menu")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menu", for: indexPath) 
        let lbl: UILabel! = UILabel(frame: CGRect(x: 0, y: 1, width: 200, height: 40))
        lbl.text = viewContollers[indexPath.row].nibName
        cell.addSubview(lbl)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewContollers.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let app = UIApplication.shared.delegate as! AppDelegate
        app.change(viewController: viewContollers[indexPath.row])

    }
}
