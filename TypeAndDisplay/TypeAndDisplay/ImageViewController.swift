import UIKit

class ImageViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet var scroll: UIScrollView!
    var img: UIImageView!
    var image: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        img = UIImageView(frame: CGRect(x:20,y:0,width:scroll.frame.width,height:scroll.frame.height))
        if(image != nil){
            img.image = image
        }else{
            img.image = UIImage(named: "Image")
        }
        
        scroll.delegate = self
        scroll.backgroundColor = UIColor.clear
        scroll.contentSize = img.bounds.size
        scroll.autoresizingMask = UIViewAutoresizing.flexibleWidth
        scroll.contentOffset = CGPoint(x:0,y:0)
        
        scroll.maximumZoomScale = 5.0
        
        let imageViewSize = img.bounds.size
        let scrollViewSize = scroll.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        
        scroll.minimumZoomScale = min(widthScale, heightScale)
        scroll.zoomScale = 1.0
        
        scroll.addSubview(img)
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return img
    }
}
