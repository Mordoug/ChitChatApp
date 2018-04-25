//
//  MessageCustomCell.swift
//  ChitChat
//
//  Created by Seielstad, Morgan on 4/17/18.
//  Copyright © 2018 Seielstad, Morgan. All rights reserved.
//

import UIKit

class MessgeCustomCell: UITableViewCell {
    var messageController : MessageController!
    
    @IBOutlet weak var MessageLabel: UILabel!
    
    @IBOutlet weak var DislikeButton: UIButton!
    @IBOutlet weak var LikeButton: UIButton!

    @IBAction func likeMessage(_ sender: Any) {
        let messageID = messageController.findMessageIDByRow(index: self.tag)
        messageController.likeMessage(messageID: messageID)
        
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //MessageLabel.adjustsFontForContentSizeCategory = true
       //MessageLabel.adjustsFontSizeToFitWidth = false
        //MessageLabel.lineBreakMode = NSLineBreakMode.byTruncatingTail
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
