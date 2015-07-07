//
//  ComposeViewController.swift
//  CampusProject
//
//  Created by Yadikaer on 7/7/15.
//  Copyright (c) 2015 Yadikaer. All rights reserved.
//

import UIKit

class AnnouncementComposetViewController: UIViewController {
    
    @IBOutlet weak var composeTextview: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        composeTextview.layer.borderColor = UIColor.grayColor().CGColor	
        composeTextview.layer.cornerRadius = 6
        composeTextview.layer.borderWidth = 1
        composeTextview.layer.masksToBounds = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func newAnnouncement(sender: AnyObject) {
        
        if(composeTextview.text == nil){
            return
        }
        
        var obj : AVObject = AVObject(className: "Announcement")
        obj.setObject(AVUser.currentUser(), forKey: "sender")
        obj.setObject(composeTextview.text, forKey: "text")
        obj.save()
        
        navigationController?.popToRootViewControllerAnimated(true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
