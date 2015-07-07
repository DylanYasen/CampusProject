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
        
        initPullRefresher()
        
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
        var query : AVQuery = AVQuery(className: "Tweet")
        query.findObjectsInBackgroundWithBlock({
            array, error in
            
            println("result")
            
            let result:NSArray = array
            let obj:[AnyObject] = array
            //let err:NSError = error
            
            if result.count>0{
                self.dataArray = result
                println(self.dataArray[0])
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
        var calendar = NSCalendar()
        let flags = NSCalendarUnit(UInt.max)
        
        var dateComponents:NSDateComponents = calendar.components(flags, fromDate: date)
        
        let yearTime:String = dateComponents.year.description + "-" + dateComponents.month.description + "-" + dateComponents.day.description
        let hourTime:String = dateComponents.hour.description + ":" + dateComponents.minute.description
        let timestamp:String = yearTime + "  " + hourTime
        
        println(timestamp)
        
        println(sender)
        println("sender name +: " + sender.username)
        
        cell.usernameLabel.text = sender.username
        cell.tweetTextview.text = tweetText
        cell.timestampLabel.text = timestamp
        
        //cell.tweetTextfield = "long ass tweet"
        println("pass")
        
        return cell
    }
    
    // move to a Common.swift
    func getUser(id:String) -> AVUser{
        
        let query : AVQuery = AVQuery(className: "_User")
        var obj : AVObject = query.getObjectWithId(id)
        
        return obj as! AVUser
    }
}
