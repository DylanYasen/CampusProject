//
//  DiscoverTableViewController.swift
//  CampusProject
//
//  Created by Yadikaer on 7/5/15.
//  Copyright (c) 2015 Yadikaer. All rights reserved.
//

import UIKit

class DiscoverTableViewController: UITableViewController {

    var dataArray:NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.rowHeight = UITableViewAutomaticDimension
        
        initPullRefresher()
        
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
    }
        
    func initPullRefresher(){
        
        // register refresh
        // will call this
        self.tableView.header = MJRefreshNormalHeader(refreshingBlock: {
            self.loadNewData()
        })
        
        // refresh now
        self.tableView.header.beginRefreshing()
    }

    
    //
    func loadNewData(){
        let query : AVQuery = AVQuery(className: "Tweet")
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
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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
        let sender:AVUser = Common.getUser(userID)
        
        // get time stamp
        let date = tweet.objectForKey("createdAt") as! NSDate
        let dateFormatter : NSDateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        let timestamp = dateFormatter.stringFromDate(date)

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
        
        cell.usernameLabel.text = sender.valueForKey("nickname") as? String
        cell.tweetTextview.text = tweetText
        cell.timestampLabel.text = timestamp
        
        
        return cell
    }
    
    
    
    
}
