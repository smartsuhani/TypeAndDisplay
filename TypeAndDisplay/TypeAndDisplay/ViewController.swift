import UIKit

class ViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
//MARK: Properties
    
    @IBOutlet var txtInput: UITextField!
    @IBOutlet var ViewTxt: UILabel!
    @IBOutlet var backbtn: UIButton!
    @IBOutlet var nextbtn: UIButton!
    @IBOutlet var imgView: UIImageView!
    var mystring: String?
    var window: UIWindow?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if mystring != nil{
            ViewTxt.text = mystring!
        }else{
            ViewTxt.text = "Enter Any Value"
        }
        txtInput.delegate = self
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    //MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard (info[UIImagePickerControllerOriginalImage] as? UIImage) != nil else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        imgView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        ViewTxt.text = textField.text
        
    }
    
    /*func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    */
    @IBAction func onTextChange(_ sender: AnyObject) {
        if txtInput.text != nil{
            ViewTxt.text = txtInput.text
        }
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    //MARK: Action
    
    @IBAction func gotonext(_ sender: UIButton) {
        let third:ThirdViewController = ThirdViewController()
        self.navigationController?.pushViewController(third, animated: true)
    }
    @IBAction func backtomain(_ sender: UIButton) {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        }
    }
    @IBAction func TapOnImage(_ sender: UITapGestureRecognizer) {
        txtInput.resignFirstResponder()
        
        let ImagePickerController = UIImagePickerController()
        ImagePickerController.sourceType = .photoLibrary
        ImagePickerController.delegate = self
        present(ImagePickerController, animated: true, completion: nil)
    }
    @IBAction func setDefaultLabel(_ sender: AnyObject) {
        ViewTxt.text = "Default Text"
    }
}

