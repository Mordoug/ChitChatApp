
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let nib = UINib.init(nibName: "MessageCustomCell", bundle: nil)
//        self.tableView.register(nib, forCellReuseIdentifier: "MessageCustomCell")
        tableView.rowHeight = CGFloat(130)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:  #selector(reloadMessages), for: UIControlEvents.valueChanged)
        self.refreshControl = refreshControl
        reloadMessages()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

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
//        let lat = messageController.findLatitueByRow(index: indexPath.row)
//        let long = messageController.findLongitudeByRow(index: indexPath.row)
//        if let latitude = Double(lat){
//            if let longitude =  Double(long){
//                let annotation = MKPointAnnotation()
//                let coord = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//                annotation.coordinate = (coord)
//                cell.mapView.addAnnotation(annotation)
//                cell.mapView.centerCoordinate = coord
//            }
//        }
        return cell
    }
    
    @IBAction func openPostPopUp(_ sender: UIBarButtonItem) {
        
        sender.isEnabled = false
        
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "postPopUp") as! PostMessagePopupViewController
        popOverVC.messageController = messageController
        popOverVC.messagesTableViewController = self
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PostMessage" {
            if let destination = segue.destination as? PostMessagePopupViewController {
                destination.messageController = self.messageController
            }
        }
    }

    
    
}
