import UIKit

class SixViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet var TxtView: UITextView!
    
    @IBOutlet var BtnWrite: UIButton!
    let fileURL = "/Users/itilak/Desktop/TypeAndDisplay/TypeAndDisplay/TypeAndDisplay/1.txt"
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        let contents: NSData!
        let dict: String!
        do {
            contents = try NSData(contentsOfFile: fileURL as String, options: NSData.ReadingOptions.dataReadingMapped)
            print(contents)
            dict = NSString(data: contents as Data, encoding: String.Encoding.utf8.rawValue) as String!
            TxtView.text = dict
        }catch{
            print("data not available")
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - IBActions
    
    @IBAction func writeToFile(_ sender: Any) {
        
        
        print("FilePath: \(fileURL)")
        let writeString = TxtView.text!
        do {
            // Write to the file
            try writeString.write(toFile: fileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("Failed writing to URL: \(fileURL), Error: " + error.localizedDescription)
        }
        
        do {
            let contents: NSData = try NSData(contentsOfFile: fileURL as String, options: NSData.ReadingOptions.dataReadingMapped)
            print(NSString(data: contents as Data, encoding: String.Encoding.utf8.rawValue) as String!)
        }catch{
            print("data not available")
        }
        
        
        
    }
    
    
    // MARK: - Navigation

}
