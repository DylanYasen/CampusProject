	//
//  LoginViewController.swift
//  CampusProject
//
//  Created by Yadikaer on 7/4/15.
//  Copyright (c) 2015 Yadikaer. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate,UIAlertViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // hide keyboard
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return false
    }
    
    @IBOutlet weak var idTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    
    var isNewUser = false
    @IBAction func OnLogin(sender: AnyObject) {
        var studentID = idTextfield.text
        var password = passwordTextfield.text
        
        var error : NSError?
        var myUser:AVUser? = AVUser.logInWithUsername(studentID, password: password, error: &error)
        
        // login succeed
        if((myUser) != nil){

            if(isNewUser){
                
                // initial avatar
                let avatarID = "55a1111ae4b06d11d32c6859" as String
                let query : AVQuery = AVQuery(className: "_File")
                var obj  = query.getObjectWithId(avatarID)
                myUser?.setObject(obj, forKey: "avatar")
                myUser?.setObject(studentID, forKey: "nickname")
                myUser?.save()
            }
            
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
        myUser.setObject(studentID, forKey: "nickname")

        
        if(myUser.signUp(&error)){
            
            
            let alert = UIAlertView()
            alert.title = "注册成功"
            alert.message = "请登录"
            alert.addButtonWithTitle("登录")
            alert.show()
            alert.delegate = self
            self.isNewUser = true
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
