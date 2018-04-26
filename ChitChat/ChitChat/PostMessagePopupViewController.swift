//
//  PostMessagePopupViewController.swift
//  ChitChat
//
//  Created by Seielstad, Morgan on 4/24/18.
//  Copyright © 2018 Seielstad, Morgan. All rights reserved.
//

import UIKit
import CoreLocation

class PostMessagePopupViewController: UIViewController {
    var messageController : MessageController!
    var messagesTableViewController: MessagesTableViewController!
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var PostTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self as? CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        
        self.view.subviews[0].layer.cornerRadius = 10.0
        self.showAnimate()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closePopUp(_ sender: AnyObject) {
        print(sender.text ?? "")

        print(String(describing: locationManager.location?.coordinate.latitude))
        if CLLocationManager.locationServicesEnabled() {
            let latitude: String = String(Double((locationManager.location?.coordinate.latitude)!))
            let longitude: String = String(Double((locationManager.location?.coordinate.longitude)!))
            messageController.postMessage(message: PostTextField.text!, latitude: latitude, longitude: longitude)
        } else {
            messageController.postMessage(message: PostTextField.text!)
        }

        messagesTableViewController.reloadMessages()
        messagesTableViewController.PostButtonBarItem.isEnabled = true
        self.removeAnimate()
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.messagesTableViewController.removePostPopUp()
            }
        });
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
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
