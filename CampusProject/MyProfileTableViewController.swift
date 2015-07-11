//
//  MyProfileTableViewController.swift
//  CampusProject
//
//  Created by Yadikaer on 7/9/15.
//  Copyright (c) 2015 Yadikaer. All rights reserved.
//

import UIKit

class MyProfileTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
 
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        //self.profileImg.image = LocalUser.profileImage
        
        // show user name
        self.nicknameLabel.text = (AVUser.currentUser().objectForKey("nickname") as! String)
        
        // show profile image
        let avatarID = AVUser.currentUser().objectForKey("avatar").objectId
        
        AVFile.getFileWithObjectId(avatarID,withBlock: {
            file,error in
            
            let imgWidth:Int32 = Int32(self.profileImg.layer.frame.width)
            let imgHeight:Int32 = Int32(self.profileImg.layer.frame.height)
            if(error == nil){
                var f : AVFile = file
                f.getThumbnail(true, width: imgWidth, height: imgHeight, withBlock: {
                    image,error in
                    
                    if error == nil{
                        self.profileImg.image = image    
                    }
                })
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let row = indexPath.row;
        let section = indexPath.section
        
        println(section)
        println(row)
        
        if section == 0 {

            if row == 0{
                 selectAvatar()
            }
            else if row == 1 {
                selectEditNickName()
            }
        }
        
        else if section == 1 {
            
        }
    }
    
    var imgPicker : UIImagePickerController?
    func selectAvatar(){
        imgPicker = UIImagePickerController()
        
        // if source available
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)){
            imgPicker!.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imgPicker!.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
            imgPicker!.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(imgPicker!.sourceType)!
        }
        
        imgPicker!.delegate = self
        imgPicker!.allowsEditing = true

        self.presentViewController(imgPicker!, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    
        // store image file on cloud
        let imgData : NSData?
            
        if(UIImagePNGRepresentation(image) != nil){
             imgData = UIImagePNGRepresentation(image)
        }
        else{
            imgData = UIImageJPEGRepresentation(image, 1.0)
        }
        
        var imgFile = AVFile.fileWithData(imgData) as! AVFile
   
        // upload image
        imgFile.saveInBackgroundWithBlock({
            saveSucceeded,saveError in
            
            if(saveSucceeded){
                
                // TODO: deleted old avatar
                
                // update user avatar info
                AVUser.currentUser().setObject(imgFile, forKey: "avatar")
                AVUser.currentUser().saveInBackground()
            }
        })
    }
    
    func selectEditNickName(){
 
       self.performSegueWithIdentifier("rename", sender: self)
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
