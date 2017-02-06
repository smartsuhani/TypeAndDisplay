import UIKit

class ScrollCell: UITableViewCell,UIScrollViewDelegate {

    @IBOutlet var lblTxt: UILabel!
    var scrollView: UIScrollView!
    var leftbtn: UIButton!
    var rightbtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.scrollView.delegate = self
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
}
