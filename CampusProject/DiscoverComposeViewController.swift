//
//  DiscoverComposeViewController.swift
//  CampusProject
//
//  Created by Yadikaer on 7/7/15.
//  Copyright (c) 2015 Yadikaer. All rights reserved.
//

import UIKit

class DiscoverComposeViewController: UIViewController {

    @IBOutlet weak var tweetTextfield: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        tweetTextfield.layer.borderColor = UIColor.grayColor().CGColor
        tweetTextfield.layer.cornerRadius = 6
        tweetTextfield.layer.borderWidth = 1
        tweetTextfield.layer.masksToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendTweet(sender: AnyObject) {
        
        if(tweetTextfield.text == nil){
            return
        }
        
        let obj : AVObject = AVObject(className: "Tweet")
        obj.setObject(AVUser.currentUser(), forKey: "sender")
        obj.setObject(tweetTextfield.text, forKey: "text")
        obj.save()
        
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
}
