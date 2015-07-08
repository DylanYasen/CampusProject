	//
//  LoginViewController.swift
//  CampusProject
//
//  Created by Yadikaer on 7/4/15.
//  Copyright (c) 2015 Yadikaer. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIAlertViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var idTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func OnLogin(sender: AnyObject) {
        var studentID = idTextfield.text
        var password = passwordTextfield.text
        
        var error : NSError?
        var myUser:AVUser? = AVUser.logInWithUsername(studentID, password: password, error: &error)
        
        // login succeed
        if((myUser) != nil){
            // transit
            self.performSegueWithIdentifier("loginSuccess", sender: self)
            
        }
        // login failed
        else{
            let alert = UIAlertView()
            alert.title = "登录失败"
  
            alert.message = error!.localizedDescription

            alert.addButtonWithTitle("重试")
            alert.show()
        }
    }
    
    @IBAction func OnSignUp(sender: AnyObject) {
        var studentID = idTextfield.text
        var password = passwordTextfield.text
        
        var error : NSError?
        
        var myUser:AVUser = AVUser()
        myUser.username = studentID
        myUser.password = password
        
        if(myUser.signUp(&error)){
            let alert = UIAlertView()
            alert.title = "注册成功"
            alert.message = "请登录"
            alert.addButtonWithTitle("登录")
            alert.show()
            alert.delegate = self
        }
        
        else{
            let alert = UIAlertView()
            alert.title = "注册失败"
            
            alert.message = error!.localizedDescription
            
            alert.addButtonWithTitle("重试")
            alert.show()
            alert.delegate = self
        }
    }
    
    // handle alert button
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        
        if(alertView.title == "注册成功"){
            OnLogin(self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
