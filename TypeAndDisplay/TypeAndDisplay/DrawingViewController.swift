import UIKit

class DrawingViewController: UIViewController,HSBColorPickerDelegate {
    
    @IBOutlet var strokeWidth: UISlider!
    //
    var lastPoint:CGPoint!
    var isSwiping:Bool!
    var red:CGFloat!
    var green:CGFloat!
    var blue:CGFloat!
    var stroke: CGFloat!
    //
    @IBOutlet var colorPicker: UIBarButtonItem!
    @IBOutlet var imageView: UIImageView!
    @IBAction func saveImage(_ sender: AnyObject) {
        if self.imageView.image == nil{
            return
        }
        UIImageWriteToSavedPhotosAlbum(self.imageView.image!,self, #selector(DrawingViewController.image(_:withPotentialError:contextInfo:)), nil)
    }
    @IBAction func undoDrawing(_ sender: AnyObject) {
        self.imageView.image = nil
    }
    func image(_ image: UIImage, withPotentialError error: NSErrorPointer, contextInfo: UnsafeRawPointer) {
//        UIAlertController(title: nil, message: "Image successfully saved to Photos library", delegate: nil, cancelButtonTitle: "Dismiss")
        let alert = UIAlertController(title: nil, message: "Image successfully saved to Photos library", preferredStyle: .alert)
        let alertaction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        
        alert.addAction(alertaction)
        
        self.present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.isNavigationBarHidden = true
        red   = (0.0/255.0)
        green = (0.0/255.0)
        blue  = (0.0/255.0)
        stroke = 9.0
        strokeWidth.maximumValue = 20.0
        strokeWidth.minimumValue = 0.1
        strokeWidth.value = Float(stroke)
        colorPicker.tintColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Touch events
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?){
        isSwiping    = false
        if let touch = touches.first{
            lastPoint = touch.location(in: imageView)
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>,
                               with event: UIEvent?){
        
        isSwiping = true;
        if let touch = touches.first{
            let currentPoint = touch.location(in: imageView)
            UIGraphicsBeginImageContext(self.imageView.frame.size)
            self.imageView.image?.draw(in: CGRect(x: 0, y: 0, width: self.imageView.frame.size.width, height: self.imageView.frame.size.height))
            UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
            UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: currentPoint.x, y: currentPoint.y))
            UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
            UIGraphicsGetCurrentContext()?.setLineWidth(stroke)
            UIGraphicsGetCurrentContext()?.setStrokeColor(red: red, green: green, blue: blue, alpha: 1.0)
            UIGraphicsGetCurrentContext()?.strokePath()
            self.imageView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            lastPoint = currentPoint
        }
    }
    
    
    @IBAction func changeWidth(_ sender: Any) {
    
        stroke = CGFloat(strokeWidth.value)
    }
    @IBOutlet var nvBar: UINavigationBar!
    var visible = 0
    @IBAction func openColorPicker(_ sender: Any) {
        if visible == 1{
            let view = self.view.subviews.last
            view?.removeFromSuperview()
            visible = 0
        }else{
            let colorView = HSBColorPicker(frame: CGRect(x:10,y:520,width:self.view.frame.width - 20,height: 200))
            colorView.layer.cornerRadius = 25
            colorView.delegate = self
            colorView.tag = 2
            self.view.addSubview(colorView)
            visible = 1
        }
        
    }
    func HSBColorColorPickerTouched(sender: HSBColorPicker, color: UIColor, point: CGPoint, state: UIGestureRecognizerState) {
        let rgbColor = color.cgColor
        self.red = rgbColor.components?[0]
        self.green = rgbColor.components?[1]
        self.blue = rgbColor.components?[2]
        
        print(red,blue,green)
    }
    override func touchesEnded(_ touches: Set<UITouch>,
                               with event: UIEvent?){
        if(!isSwiping) {
            // This is a single touch, draw a point
            UIGraphicsBeginImageContext(self.imageView.frame.size)
            self.imageView.image?.draw(in: CGRect(x: 0, y: 0, width: self.imageView.frame.size.width, height: self.imageView.frame.size.height))
            UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
            UIGraphicsGetCurrentContext()?.setLineWidth(9.0)
            UIGraphicsGetCurrentContext()?.setStrokeColor(red: red, green: green, blue: blue, alpha: 1.0)
            UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
            UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
            UIGraphicsGetCurrentContext()?.strokePath()
            self.imageView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
    }}

