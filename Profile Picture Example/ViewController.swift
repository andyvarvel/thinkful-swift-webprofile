//
//  ViewController.swift
//  Profile Picture Example
//
//  Created by ANDREW VARVEL on 8/09/2014.
//  Copyright (c) 2014 Andrew Varvel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    @IBOutlet weak var profilePicture: UIImageView!
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.profilePicture.alpha = 0.0 //Hide imageView until we get the data
        
        let myProfilePictureURL = NSURL(string: "http://graph.facebook.com/andrewv/picture?type=square&width=250&height=250")
        
        let activityIndictorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        activityIndictorView.center = self.view.center
        self.view.addSubview(activityIndictorView)
        activityIndictorView.startAnimating()
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            // Do some async stuff
            let imageData = NSData(contentsOfURL: myProfilePictureURL)
            
            NSOperationQueue.mainQueue().addOperationWithBlock {
                // Do some main thread stuff
                self.profilePicture.image = UIImage(data: imageData)
                activityIndictorView.stopAnimating()
                
                UIView.animateWithDuration(1.0, animations: {
                    self.profilePicture.alpha = 1.0
                    }, completion: {
                        (value: Bool) in
                        println("Animation complete!")
                })
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

