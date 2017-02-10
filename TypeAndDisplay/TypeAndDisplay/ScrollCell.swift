import UIKit

class ScrollCell: UITableViewCell,UIScrollViewDelegate {

    @IBOutlet var view1: UIView!
    @IBOutlet var lblTxt: UILabel!
    @IBOutlet var scroll: UIScrollView!
    var lastContentOffset: CGFloat!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        scroll.delegate = self
        lastContentOffset = scroll.contentOffset.x
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset > scrollView.contentOffset.x) {
            scroll.setContentOffset(CGPoint(x: -55,y: scroll.contentOffset.y), animated: true)
        }
    }
    @IBAction func b1(_ sender: Any) {
        if(scroll.isDragging ==  false){
            scroll.setContentOffset(CGPoint(x:self.lastContentOffset,y: 0), animated: true)
        }
    }
    @IBAction func b2(_ sender: Any) {
        if(scroll.isDragging ==  false){
            scroll.setContentOffset(CGPoint(x:self.lastContentOffset,y: 0), animated: false)
        }
    }
}
