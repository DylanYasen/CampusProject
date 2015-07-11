//
//  RenameViewController.swift
//  CampusProject
//
//  Created by Yadikaer on 7/10/15.
//  Copyright (c) 2015 Yadikaer. All rights reserved.
//

import UIKit

class RenameViewController: UIViewController {

    @IBOutlet weak var renameTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        renameTextfield.text = AVUser.currentUser().objectForKey("nickname") as! String
    }
    
    @IBAction func OnSave(sender: AnyObject) {
        
        let newName = renameTextfield.text;
        AVUser.currentUser().setObject(newName, forKey: "nickname")
        AVUser.currentUser().saveInBackground()
        
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
