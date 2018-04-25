//
//  PostMessagePopupViewController.swift
//  ChitChat
//
//  Created by Seielstad, Morgan on 4/24/18.
//  Copyright © 2018 Seielstad, Morgan. All rights reserved.
//

import UIKit

class PostMessagePopupViewController: UIViewController {
    var messageController : MessageController!
    @IBAction func messageBox(_ sender: UITextField) {
        print(sender.text ?? "")
        messageController.postMessage(message: sender.text ?? "")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
