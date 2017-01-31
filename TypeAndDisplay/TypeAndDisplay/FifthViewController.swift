import UIKit

class FifthViewController: UITabBarController,UITabBarControllerDelegate {

    var tab1: ThirdViewController!
    var tab2: FourthViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        tab1 = ThirdViewController()
        tab1.tabBarItem = UITabBarItem(title: "Images", image: UIImage(named: "imageicon"), selectedImage: UIImage(named: "imageicon"))
        
        tab2 = FourthViewController()
        tab2.tabBarItem = UITabBarItem(title: "User", image: UIImage(named: "usericon"), selectedImage: UIImage(named: "usericon"))
        
        self.viewControllers = [tab1,tab2]


    }    
    // MARK: - Navigation

}
