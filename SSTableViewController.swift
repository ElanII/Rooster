//
//  SSTableViewController.swift
//  Rooster
//
//  Created by raja adabala on 11/2/15.
//  Copyright © 2015 rajaadabala. All rights reserved.
//

import UIKit

var activeStdSumSheetRow = -1
class SSTableViewController: UITableViewController {

    let activeCourseId = profCourseTable[activeCourseRow]["courseNum"]
    //let activeRoosterSheetId = profCourseTable[activeCourseRow].sheets[activeRoosterSheetRow].sheetId
    //var stdRecordsTable = profTable[activeCourseRow].sheets[activeRoosterSheetRow].students
    
    let activeStdSheetId = roosterSheetCourseTable[activeRoosterSheetRow]["sheetId"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activeStdSumSheetRow = -1
        
        if NSUserDefaults.standardUserDefaults().objectForKey("\(activeCourseId!)\(activeStdSheetId!)stdRecordsTable") != nil {
            stdRecordsTable = NSUserDefaults.standardUserDefaults().objectForKey("\(activeCourseId!)\(activeStdSheetId!)stdRecordsTable") as! [Dictionary<String, String>]
            if stdRecordsTable.isEmpty {
                log("\(activeCourseId!)\(activeStdSheetId!)stdRecordsTable is empty ")
            }
        } else {
            log("\(activeCourseId!)\(activeStdSheetId!)stdRecordsTable does not exists in NSUserDefaults")
        }
        log()
        
        /*
        
        
        if NSUserDefaults.standardUserDefaults().objectForKey("stdRecordsTable") != nil {
            stdRecordsTable = NSUserDefaults.standardUserDefaults().objectForKey("stdRecordsTable") as! [String : [Dictionary<String, String>] ]
            if stdRecordsTable[activeRoosterSheetId!] == nil {
                log("stdRecordsTable is empty ")
            }
        } else {
            log("stdRecordsTable does not exists in NSUserDefaults")
        }
        */
        
        //print(stdRecordsTable[activeRoosterSheetRow])
        /*
        let date = NSDate()
        roosterSheetCourseTable.append(["rSheetId" : String(Int(date.hash)), "rSheetDate" : String(date)])
        print("\(__FUNCTION__)")
        print(roosterSheetCourseTable.last)
        NSUserDefaults.standardUserDefaults().setObject(roosterSheetCourseTable,
            forKey: "\(activeCourseId)roosterSheetCourseTable")
        */

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stdRecordsTable.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RoosterSheetStdCell", forIndexPath: indexPath)
        
        
        // Configure the cell...
        cell.textLabel?.text = stdRecordsTable[indexPath.row]["stdName"]
        return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        activeStdSumSheetRow = indexPath.row
        //activeRoosterSheetId = roosterSheetCourseTable[activeCourseId!]![indexPath.row]["rSheetId"] ?? ""
        return indexPath
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "newPlace" {
            print("new place", terminator: "")
            activeStdSumSheetRow = -1
        }
        log("segue called for SSTableViewController !")
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            stdRecordsTable.removeAtIndex(indexPath.row)
            NSUserDefaults.standardUserDefaults().setObject(stdRecordsTable, forKey: "\(activeCourseId!)\(activeStdSheetId!)stdRecordsTable" )
            self.tableView.reloadData()
        }
        
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
