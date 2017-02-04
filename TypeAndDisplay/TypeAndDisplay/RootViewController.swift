
import UIKit

class RootViewController: UIViewController,UIScrollViewDelegate {

    
    @IBOutlet var View1: UIScrollView!
    var viewController: ViewController!
    var secondViewController: SecondViewController!
    var thirdViewController: ThirdViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        View1.delegate = self
        View1.isScrollEnabled = true
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loadFirstView(_ sender: Any) {
        print("First")
//        View1 = viewController.view
        let vc = FifthViewController(nibName: "FifthViewController", bundle: nil)
        View1.addSubview(vc.view)
        View1.contentSize = vc.view.frame.size
        self.addChildViewController(vc)
    }
    
    @IBAction func loadSecondView(_ sender: Any) {
        print("Second")

        let vc = SecondViewController(nibName: "SecondViewController", bundle: nil)
        View1.addSubview(vc.view)
        View1.contentSize = vc.view.frame.size
        self.addChildViewController(vc)
    }
    @IBAction func loadThirdView(_ sender: Any) {
        print("Third")
        let vc = ThirdViewController(nibName: "ThirdViewController", bundle: nil)
        View1.addSubview(vc.view)
        View1.contentSize = vc.view.frame.size
        self.addChildViewController(vc)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let foregroundHeight = View1.contentSize.height - CGRectGetHeight(View1.bounds)
//        let percentageScroll = View1.contentOffset.y / foregroundHeight
//        let backgroundHeight = background.contentSize.height - CGRectGetHeight(background.bounds)
//        
//        background.contentOffset = CGPoint(x: 0, y: backgroundHeight * percentageScroll)
    }
    // MARK: - Navigation

 

}
