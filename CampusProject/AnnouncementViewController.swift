//
//  CampusTableViewController.swift
//  CampusProject
//
//  Created by Yadikaer on 7/5/15.
//  Copyright (c) 2015 Yadikaer. All rights reserved.
//

import UIKit

class AnnouncementViewController: UITableViewController {

    var dataArray:NSArray = NSArray()
    
    @IBOutlet weak var newAnnouncementBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // test
        /*
        var obj : AVObject = AVObject(className: "Tweet")
        obj.setObject(AVUser.currentUser(), forKey: "sender")
        obj.setObject("this is a test tweet", forKey: "text")
        obj.save()
        */
        initPullRefresher()
        
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(animated: Bool) {
        
        // hide new new-Announcement-button for students
        if AVUser.currentUser().username != "admin"{
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    
    func initPullRefresher(){
        
        // register refresh
        // will call this
        self.tableView.header = MJRefreshNormalHeader(refreshingBlock: {
            self.loadData()
        })
        
        // refresh now
        self.tableView.header.beginRefreshing()
    }
    
    
    func loadData(){
    
        let query : AVQuery = AVQuery(className: "Announcement")
        query.findObjectsInBackgroundWithBlock({
            array, error in
            
            print("result")
            
            let result:NSArray = array
            let obj:[AnyObject] = array
            //let err:NSError = error
            
            if result.count>0{
                self.dataArray = result
                print(self.dataArray[0])
            }
            
            // order by date (latest the topest)
            self.dataArray = self.dataArray.reverseObjectEnumerator().allObjects;
            
            self.tableView.reloadData()
            self.tableView.header.endRefreshing()

            //let sweet:AVObject = self.dataArray.objectAtIndex(0) as! AVObject
            //println(sweet.valueForKey("text"))
        })
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // init
        let cellIdentifier : String = "cell"
        let row = indexPath.row
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TweetTableViewCell
        
        // get tweet object
        let tweet:AVObject = self.dataArray.objectAtIndex(row) as! AVObject
        
        // get content text
        let tweetText = tweet.valueForKey("text") as! String
        
        // get user
        let userID = tweet.objectForKey("sender").objectId
        let sender:AVUser = getUser(userID)
        
        // get time stamp
        let date = tweet.objectForKey("createdAt") as! NSDate
        let dateFormatter : NSDateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        let timestamp = dateFormatter.stringFromDate(date)
               
        cell.usernameLabel.text = sender.valueForKey("nickname") as? String
        cell.tweetTextview.text = tweetText
        cell.timestampLabel.text = timestamp
        
        // get avatar
        // show profile image
        let avatarID = sender.objectForKey("avatar").objectId
        
        // set avatar
        AVFile.getFileWithObjectId(avatarID,withBlock: {
            file,error in
            
            let imgWidth:Int32 = Int32(cell.avatarImg.layer.frame.width)
            let imgHeight:Int32 = Int32(cell.avatarImg.layer.frame.height)
            if(error == nil){
                let f : AVFile = file
                f.getThumbnail(true, width: imgWidth, height: imgHeight, withBlock: {
                    image,error in
                    
                    if error == nil{
                        cell.avatarImg.image = image
                    }
                })
            }
        })
        
        return cell
    }

    
    // move to a Common.swift
    func getUser(id:String) -> AVUser{
        
        let query : AVQuery = AVQuery(className: "_User")
        let obj : AVObject = query.getObjectWithId(id)
        
        return obj as! AVUser
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return dataArray.count
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
