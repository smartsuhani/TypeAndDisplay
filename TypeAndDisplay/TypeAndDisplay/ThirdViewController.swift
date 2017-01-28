import UIKit

class ThirdViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {

    @IBOutlet var view1: UIView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var backbtn: UIButton!
    @IBOutlet var rootbtn: UIButton!
    var imView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 25)
        layout.itemSize = CGSize(width: 100, height: 100)
        
        collectionView = UICollectionView(frame: self.view1.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = UIColor.clear
        self.view1.addSubview(collectionView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func gotoroot(_ sender: UIButton) {
        if let nav = self.navigationController {
            nav.popToRootViewController(animated: true)
        }
    }
    @IBAction func back(_ sender: UIButton) {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 21
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath)
        cell.backgroundColor = UIColor.cyan
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
