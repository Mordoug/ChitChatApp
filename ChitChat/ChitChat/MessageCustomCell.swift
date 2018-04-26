//
//  MessageCustomCell.swift
//  ChitChat
//
//  Created by Seielstad, Morgan on 4/17/18.
//  Copyright © 2018 Seielstad, Morgan. All rights reserved.
//

import UIKit
import MapKit


class MessgeCustomCell: UITableViewCell {
    var messageController : MessageController!

    
    
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var dislikeButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBAction func likeMessage(_ sender: Any) {
        let messageID = messageController.findMessageIDByRow(index: self.tag)
        messageController.liked.append(messageID)
        messageController.likeMessage(messageID: messageID)
        var numlikes = messageController.findLikesByRow(index: self.tag)
        numlikes += 1
        likeButton.setTitle("Likes: " + String(numlikes), for: .normal)
        likeButton.isEnabled = false
    }
    @IBAction func dislikeMessage(_ sender: Any) {
        
        let messageID = messageController.findMessageIDByRow(index: self.tag)
        messageController.dislikeMessage(messageID: messageID)
        messageController.disliked.append(messageID)
        var numdislikes = messageController.findDislikesByRow(index: self.tag)
        numdislikes += 1
        dislikeButton.setTitle("Dislikes: " + String(numdislikes), for: .normal)
        dislikeButton.isEnabled = false

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
