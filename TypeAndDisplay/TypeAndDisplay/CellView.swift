import UIKit
import CoreImage

class CellView: UITableViewCell{

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblSubtitle: UILabel!
    var rightBtn = UIButton()
    var leftBtn = UIButton()
    @IBOutlet var imgBarcode: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
//         Initialization code
        let leftSwipe = UISwipeGestureRecognizer(target: self, action:#selector(CellView.swipe(sender:)))
        leftSwipe.direction = .right;
        self.addGestureRecognizer(leftSwipe)
        let rightSwipe = UISwipeGestureRecognizer(target: self, action:#selector(CellView.swipe(sender:)))
        leftSwipe.direction = .left;
        self.addGestureRecognizer(rightSwipe)
        
        imgBarcode.image = self.fromString(string: lblName.text!)
    }
    
    func fromString(string : String) -> UIImage? {
        
        let data = string.data(using: String.Encoding.ascii)
        let filter = CIFilter(name: "CICode128BarcodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        return UIImage(ciImage: (filter?.outputImage)!)
        
    }
    
    func swipe(sender:AnyObject)
    {
        let swipeGesture:UISwipeGestureRecognizer = sender as! UISwipeGestureRecognizer
        self.rightBtn.alpha = 0
        if(swipeGesture.direction == .right)
        {
            self.rightBtn = UIButton(frame: CGRect(x: -70,y: 0,width: 70,height:50))
            self.rightBtn.layer.cornerRadius = 5
            UIView.animate(withDuration: 0.8, animations: {
                
                self.imgView.frame = CGRect(x: 70,y: 0,width: self.imgView.frame.width,height: self.imgView.frame.height)
                self.lblName.frame = CGRect(x: self.imgView.frame.width + 80,y: 8,width: self.lblName.frame.width,height: self.lblName.frame.height)
                self.lblSubtitle.frame = CGRect(x: self.imgView.frame.width + 80,y: 26,width: self.lblSubtitle.frame.width,height: self.lblSubtitle.frame.height)
                self.rightBtn.frame = CGRect(x: 0,y: 0,width:70,height:50)
                self.rightBtn.backgroundColor = UIColor.cyan
                self.rightBtn.setTitle("Right", for: .normal)
                self.rightBtn.setTitleColor(UIColor.darkGray, for: .normal)
                self.rightBtn.alpha = 1
                self.contentView.addSubview(self.rightBtn)
            }, completion: { (bool) in
        self.rightBtn.addTarget(SecondViewController(), action: #selector(SecondViewController.tapped), for: .touchDown)
            })

            print("swipe right")
        }else if(swipeGesture.direction == .left){
            UIView.animate(withDuration: 0.8, animations: {
                
                self.imgView.frame = CGRect(x: 15,y: 0,width: self.imgView.frame.width,height: self.imgView.frame.height)
                self.lblName.frame = CGRect(x: 71,y: 8,width: self.lblName.frame.width,height: self.lblName.frame.height)
                self.lblSubtitle.frame = CGRect(x: 71,y: 26,width: self.lblSubtitle.frame.width,height: self.lblSubtitle.frame.height)
                self.rightBtn.frame = CGRect(x: -70,y: 0,width: 70,height:50)
            }, completion: nil)
            
            print("swipe left")
        }
    }
}
