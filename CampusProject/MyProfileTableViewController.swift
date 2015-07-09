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
 
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.profileImg.image = LocalUser.profileImage

        
        /*
        AVUser.currentUser().refreshInBackgroundWithBlock({
            obj, error in
            
            if(error == nil){
            
                var filePtr = AVUser.currentUser().objectForKey("avatar") as! AVFile
            
                if(filePtr == nil){
                    println("file nil")
                    return
                }
                
                var file : AVFile = filePtr.memory
    
                // TODO
                let url = NSURL(string: file.url)
                let data = NSData(contentsOfURL: url!)
                        
                var img : UIImage = UIImage(data:data!)!
                self.profileImg.image = img
            }
            
        })

        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var row : Int = indexPath.row;
        
        switch(row){
            
        case 0:
            selectAvatar()
            break;
            
            
        default:
            break;
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
        let imgData : NSData = UIImagePNGRepresentation(image)
        var imgFile = AVFile.fileWithData(imgData) as! AVFile
        
        // save it locally
        LocalUser.profileImage = image
        
        // upload image
        imgFile.saveInBackgroundWithBlock({
            saveSucceeded,saveError in
            
            if(saveSucceeded){
                
                // update user info
                AVFile.getFileWithObjectId(imgFile.objectId, withBlock: {
                    file, error in
                    
                    if(error == nil){
                        // update user avatar
                        AVUser.currentUser().setObject(file, forKey: "avatar")
                        AVUser.currentUser().saveInBackground()
                    }
                })
                
            }
        })
        
    }
    
    
    
    func selectNickName(){
        
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
