
//  MessagesTableViewController.swift
//  ChitChat
//
//  Created by Seielstad, Morgan on 4/14/18.
//  Copyright © 2018 Seielstad, Morgan. All rights reserved.
//

import UIKit
import MapKit
class MessagesTableViewController: UITableViewController, CLLocationManagerDelegate {
    var messageController : MessageController!
    
    @IBOutlet weak var PostButtonBarItem: UIBarButtonItem!
    
    var popOverVC: DetailsPopupViewController!
    var postPopOverVC: PostMessagePopupViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.allowsSelection = true
        tableView.rowHeight = CGFloat(130)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:  #selector(reloadMessages), for: UIControlEvents.valueChanged)
        self.refreshControl = refreshControl
//
//        var recognizer = UISwipeGestureRecognizer(target: self, action: "didSwipe")
//        self.tableView.addGestureRecognizer(recognizer)
	
        reloadMessages()
        
        
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewDidAppear(_ animated: Bool) {
        reloadMessages()
    }
    
    @objc func reloadMessages() {
        messageController.getMessages { (error: Error?) in
            if let error = error {
                print(error)
                print("oH")
                //TODO: Popup error
            } else {
                print("reload")
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messageController.messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCustomCell", for: indexPath) as! MessgeCustomCell
        let place = messageController.messages[indexPath.row]
        cell.tag = indexPath.row
      
        cell.messageController = self.messageController
        cell.messageLabel.text = place.message
        cell.timeStampLabel.text = place.dates
        cell.likeButton.setTitle("Likes: " + String(place.likes), for: .normal)
        if messageController.liked.contains(place._id){
            cell.likeButton.isEnabled = false
        } else {
            cell.likeButton.isEnabled = true
        }
        cell.dislikeButton.setTitle("Dislikes: " + String(place.dislikes), for: .normal)
         if messageController.disliked.contains(place._id){
            cell.dislikeButton.isEnabled = false
         }else {
            cell.dislikeButton.isEnabled = true
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let like = UIContextualAction(style: .normal, title: "Like"){ (action, view, handler) in
            let cell = tableView.cellForRow(at: indexPath) as! MessgeCustomCell
            cell.likeMessage(self)
        
        }
        let configuration = UISwipeActionsConfiguration(actions: [like])
        return configuration
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let dislike = UIContextualAction(style: .normal, title: "Dislike"){ (action, view, handler) in
            let cell = tableView.cellForRow(at: indexPath) as! MessgeCustomCell
            cell.dislikeMessage(self)
            
        }
        let configuration = UISwipeActionsConfiguration(actions: [dislike])
        return configuration
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailsPopup") as! DetailsPopupViewController
        popOverVC.messageController = messageController
        popOverVC.message = messageController.messages[indexPath.row]
        popOverVC.messageTableViewController = self
        popOverVC.row = indexPath.row
        popOverVC.modalPresentationStyle = .popover
        popOverVC.definesPresentationContext = true
        //self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
//        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
        
        //self.navigationController?.view.addSubview(popOverVC.view)
        self.navigationController?.view.addSubview(popOverVC.view)
        
    }
    
    func removeDetailsPopUp() {
        popOverVC.view.removeFromSuperview()
    }
    
    func removePostPopUp() {
        postPopOverVC.view.removeFromSuperview()
    }
    
    @IBAction func openPostPopUp(_ sender: UIBarButtonItem) {
        
        //sender.isEnabled = false
        
        postPopOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "postPopUp") as! PostMessagePopupViewController
        postPopOverVC.view.frame = self.view.frame
        postPopOverVC.messageController = messageController
        postPopOverVC.messagesTableViewController = self
        self.view.addSubview(postPopOverVC.view)
        postPopOverVC.didMove(toParentViewController: self)
        
        self.navigationController?.view.addSubview(postPopOverVC.view)
    }
    
    @IBAction func loadMessages(_ sender: Any) {
        messageController.getMoreMessages{ (error: Error?) in
            if let error = error {
                print(error)
                print("oH")
                //TODO: Popup error
            } else {
                print("reload")
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PostMessage" {
            if let destination = segue.destination as? PostMessagePopupViewController {
                destination.messageController = self.messageController
            }
        }
    }
}
