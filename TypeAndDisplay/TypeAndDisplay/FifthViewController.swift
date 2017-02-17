import UIKit

class FifthViewController: UITabBarController,UITabBarControllerDelegate {

    var tab1: RootViewController!
    var tab2: NinthViewController!
    var tab3: SixViewController!
    var tab4: SeventhViewController!
    var tab5: EightViewController!
    var tab6: MapViewController!
    var tab7: RegisterViewController!
    var tab8: WebViewController!
    var tab9: FetchViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        tab1 = RootViewController()
        tab1.tabBarItem = UITabBarItem(title: "splitview", image: UIImage(named: "split"), selectedImage: UIImage(named: "split"))
        
        tab2 = NinthViewController()
        tab2.tabBarItem = UITabBarItem(title: "animation", image: UIImage(named: "animation"), selectedImage: UIImage(named: "animation"))
        
        tab3 = SixViewController()
        tab3.tabBarItem = UITabBarItem(title: "file", image: UIImage(named: "file"), selectedImage: UIImage(named: "file"))
        
        tab4 = SeventhViewController()
        tab4.tabBarItem = UITabBarItem(title: "page", image: UIImage(named: "page"), selectedImage: UIImage(named: "page"))
        
        tab5 = EightViewController()
        tab5.tabBarItem = UITabBarItem(title: "scroll", image: UIImage(named: "scroll"), selectedImage: UIImage(named: "scroll"))
        
        tab6 = MapViewController()
        tab6.tabBarItem = UITabBarItem(title: "map", image: UIImage(named: "map"), selectedImage: UIImage(named: "map"))
        
        tab7 = RegisterViewController()
        tab7.tabBarItem = UITabBarItem(title: "register", image: UIImage(named: "register"), selectedImage: UIImage(named: "register"))
        
        tab8 = WebViewController()
        tab8.tabBarItem = UITabBarItem(title: "web", image: UIImage(named: "web"), selectedImage: UIImage(named: "web"))
        
        tab9 = FetchViewController()
        tab9.tabBarItem = UITabBarItem(title: "image", image: UIImage(named: "image"), selectedImage: UIImage(named: "image"))
        
        let tab10 = LazyViewController()
        tab10.tabBarItem = UITabBarItem(title: "lazy", image: nil, selectedImage: nil)
        
        self.viewControllers = [tab10,tab3,tab4,tab5,tab2,tab1,tab6,tab7,tab8,tab9]


    }

    // MARK: - Navigation

}
