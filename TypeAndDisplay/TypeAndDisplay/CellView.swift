//
//  CellView.swift
//  TypeAndDisplay
//
//  Created by Devloper30 on 30/01/17.
//  Copyright © 2017 lanetteamLanet. All rights reserved.
//

import UIKit

class CellView: UITableViewCell/*,UIScrollViewDelegate*/{

    //var Scroll: UIScrollView!

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblSubtitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
      //  self.Scroll.delegate = self
//        let frame = View1.frame
//        self.frame.origin = frame.origin
        
        
        
        // Initialization code
//        let leftSwipe = UISwipeGestureRecognizer(target: self, action:#selector(CellView.swipe(sender:)))
//        leftSwipe.direction = .right;
//        self.addGestureRecognizer(leftSwipe)
//        let rightSwipe = UISwipeGestureRecognizer(target: self, action:#selector(CellView.swipe(sender:)))
//        leftSwipe.direction = .left;
//        self.addGestureRecognizer(rightSwipe)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    func swipe(sender:AnyObject)
//    {
//        let swipeGesture:UISwipeGestureRecognizer = sender as! UISwipeGestureRecognizer
//        if(swipeGesture.direction == .right)
//        {
//            var frame:CGRect = self.frame
//            frame.origin.x = +self.Btnleft.frame.width
//            self.frame = frame
//            print("swipe right")
//        }else if(swipeGesture.direction == .left){
//            var frame:CGRect = self.frame;
//            frame.origin.x = -self.Btnleft.frame.width;
//            self.frame = frame;
//            print("swipe left")
//        }
//    }
}
