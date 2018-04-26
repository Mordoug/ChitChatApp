//
//  DetailsPopupViewController.swift
//  ChitChat
//
//  Created by Matthew Fortier on 4/25/18.
//  Copyright © 2018 Seielstad, Morgan. All rights reserved.
//

import UIKit
import MapKit

class DetailsPopupViewController: UIViewController {
    
    var messageTableViewController: MessagesTableViewController!
    var messageController: MessageController!
    var message: Message!
    
    var row: Int!

    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet var MapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAnimate()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let lat = messageController.findLatitueByRow(index: row)
        let long = messageController.findLongitudeByRow(index: row)
        if let latitude = Double(lat){
            if let longitude =  Double(long){
                let annotation = MKPointAnnotation()
                let coord = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                annotation.coordinate = (coord)
                MapView.addAnnotation(annotation)
                MapView.centerCoordinate = coord
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closePopUp(_ sender: UIButton) {
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
                self.messageTableViewController.removeDetailsPopUp()
            }
        });
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
