import UIKit

class NinthViewController: UIViewController {

    var view1: UIView!
    var scaleFactor: CGFloat = 4
    var angle: Double = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let frame1 = CGRect(x: 0,y: 0,width:50,height:50)
        UIView.animate(withDuration: 0.8, animations: {
            self.view1 = UIView(frame: frame1)
            self.view1.center = self.view.center
            self.view1.backgroundColor = UIColor.blue
            self.view.addSubview(self.view1)
        }, completion: nil)
        let frame2 = CGRect(x:20,y:0,width:10,height:50)
        let view2 = UIView(frame: frame2)
        view2.backgroundColor = UIColor.white
        view1.addSubview(view2)
        
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){
        let touch = touches.first! as UITouch
        let location = touch.location(in: self.view)
        UIView.animate(withDuration: 0.8, animations: {
            let scaleTrans =
                CGAffineTransform(scaleX: self.scaleFactor,
                                  y: self.scaleFactor)
            let rotateTrans = CGAffineTransform(
                rotationAngle: CGFloat(self.angle * M_PI / 180))
            
            self.view1.transform =
                scaleTrans.concatenating(rotateTrans)
            
            self.angle = (self.angle == 60 ? 360 : 60)
            self.scaleFactor = (self.scaleFactor == 2 ? 1 : 2)
            self.view1.center = location
        }, completion: nil)
    }
    
}
