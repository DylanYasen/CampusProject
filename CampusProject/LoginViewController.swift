	//
//  LoginViewController.swift
//  CampusProject
//
//  Created by Yadikaer on 7/4/15.
//  Copyright (c) 2015 Yadikaer. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBOutlet weak var idTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func OnLogin(sender: AnyObject) {
        var studentID = idTextfield.text
        var password = passwordTextfield.text
        
        var error : NSErrorPointer = NSErrorPointer()
        
        var myUser:AVUser? = AVUser.logInWithUsername(studentID, password: password, error: error)
        
        if((myUser) != nil){
            
            println("successfully login")
            
            // transit
            self.performSegueWithIdentifier("loginSuccess", sender: self)
            
        }
        else{
            println(error.debugDescription)
        }
    }
    
    @IBAction func OnSignUp(sender: AnyObject) {
        var studentID = idTextfield.text
        var password = passwordTextfield.text
        
        var error : NSErrorPointer = NSErrorPointer()
        
        var myUser:AVUser = AVUser()
        myUser.username = studentID
        myUser.password = password
        
        if(myUser.signUp(error)){
            println("successfully sign up")
        }
        
        println(error.debugDescription)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
