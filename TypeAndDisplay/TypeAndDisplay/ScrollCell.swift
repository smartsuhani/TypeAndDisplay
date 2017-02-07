import UIKit

class ScrollCell: UITableViewCell {

    @IBOutlet var view1: UIView!
    @IBOutlet var lblTxt: UILabel!
    @IBOutlet var scroll: UIScrollView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
