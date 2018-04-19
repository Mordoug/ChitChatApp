//
//  MessagesTableViewController.swift
//  ChitChat
//
//  Created by Seielstad, Morgan on 4/14/18.
//  Copyright © 2018 Seielstad, Morgan. All rights reserved.
//

import UIKit

class MessagesTableViewController: UITableViewController {
    var messageController : MessageController!

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: "MessageCustomCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "MessageCustomCell")
        tableView.rowHeight = CGFloat(130)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:  #selector(reload), for: UIControlEvents.valueChanged)
        self.refreshControl = refreshControl
        reloadMessages()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func reloadMessages() {
        messageController.getMessages { (error: Error?) in
            if let error = error {
                print(error)
                
                //TODO: Popup error
                
            }else {
                
                    self.reload()
                }
                
            }
            
        
    }
    
    @objc func reload() {
        
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
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
        cell.MessageLabel.text = place.message
        return cell
    }
    


}
