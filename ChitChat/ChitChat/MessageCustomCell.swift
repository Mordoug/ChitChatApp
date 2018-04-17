//
//  MessageCustomCell.swift
//  ChitChat
//
//  Created by Seielstad, Morgan on 4/17/18.
//  Copyright © 2018 Seielstad, Morgan. All rights reserved.
//

import UIKit

class MessgeCustomCell: UITableViewCell {
    
 
    @IBOutlet weak var MessageLabel: UILabel!
    
    @IBOutlet weak var DislikeButton: UIButton!
    @IBOutlet weak var LikeButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //CellLabel.adjustsFontForContentSizeCategory = true
       //MessageLabel.adjustsFontSizeToFitWidth = false
        //MessageLabel.lineBreakMode = NSLineBreakMode.byTruncatingTail
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
