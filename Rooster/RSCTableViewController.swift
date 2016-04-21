//
//  RSCTableViewController.swift
//  Rooster
//
//  Created by raja adabala on 11/2/15.
//  Copyright © 2015 rajaadabala. All rights reserved.
//

import UIKit

//var roosterSheetCourseTable:[String : [Dictionary<String, String>] ] = [:]
var activeRoosterSheetRow = -1
var activeTotalSheets = -1
var totalStudents = 0
//var activeRoosterSheetId = ""


// = minor no , name , attendance/
//NSUserDefaults.standardUserDefaults().objectForKey("\(activeCourseRow)roosterSheetCourseTable")

class RSCTableViewController: UITableViewController {
    
    
   // let activeCourseId = profTable[activeCourseRow].courseId
    //var roosterSheetCourseTable = profTable[activeCourseRow].sheets
    
    let activeCourseId = profCourseTable[activeCourseRow]["courseNum"]
    //var roosterSheetCourseTable = profCourseTable[activeCourseRow].sheets
    
    //roosterSheetCourseTable
    override func viewDidLoad() {
        log()
        super.viewDidLoad()
        totalStudents = 0
        activeRoosterSheetRow = -1
        
        /*
        activeTotalSheets = roosterSheetCourseTable.count
        if roosterSheetCourseTable.isEmpty {
            log("roosterSheetCourseTable is empty ")
        }
        */
        
        log(activeCourseId!)
        
        if NSUserDefaults.standardUserDefaults().objectForKey("\(activeCourseId!)roosterSheetCourseTable") != nil {
            roosterSheetCourseTable = NSUserDefaults.standardUserDefaults().objectForKey("\(activeCourseId!)roosterSheetCourseTable") as! [Dictionary<String, String>]
            if roosterSheetCourseTable.isEmpty {
                log("\(activeCourseId!)roosterSheetCourseTable is empty ")
            }
        } else {
            log("\(activeCourseId!)roosterSheetCourseTabledoes not exists in NSUserDefaults")
        }
        
        stdRecordsTable = []
        
        //stdRecordsTable = ["abcrow" : [ "name" : "raja adabala" ]]
        //NSUserDefaults.standardUserDefaults().setObject(stdRecordsTable, forKey: "stdRecordsTable" )
        //log(stdRecordsTable["abcrow"]!["name"]!)
        
        /*
        if NSUserDefaults.standardUserDefaults().objectForKey("roosterSheetCourseTable") != nil {
            roosterSheetCourseTable = NSUserDefaults.standardUserDefaults().objectForKey("roosterSheetCourseTable") as! [String : [Dictionary<String, String>] ]
            if roosterSheetCourseTable[activeCourseId!] == nil {
                log("roosterSheetCourseTable is empty ")
            }
        } else {
            log("roosterSheetCourseTable does not exists in NSUserDefaults")
        }
        */
        
        
        
        /*
        if NSUserDefaults.standardUserDefaults().objectForKey("profCourseTable") != nil {
            profCourseTable = NSUserDefaults.standardUserDefaults().objectForKey("profCourseTable") as! [Dictionary<String, String>]
            if profCourseTable == [] {
                print("profCourseTable is empty ")
            }
        } else {
            print("profCourseTable does not exists in NSUserDefaults")
        }
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
        
        return roosterSheetCourseTable.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CourseRoosterSheetCell", forIndexPath: indexPath)
        
        
        // Configure the cell...
        //cell.textLabel?.text = roosterSheetCourseTable[indexPath.row].sheetName
        cell.textLabel?.text = roosterSheetCourseTable[indexPath.row]["sheetName"]
        return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        activeRoosterSheetRow = indexPath.row
        
        stdRecordsTable = []
        //activeRoosterSheetId = roosterSheetCourseTable[activeCourseId!]![indexPath.row]["rSheetId"] ?? ""
        return indexPath
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "newPlace" {
            print("new place", terminator: "")
            activeRoosterSheetRow = -1
        }
        
        log("segue called for RSCTableViewController !")
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            //let activeCourseId = profCourseTable[activeCourseRow]["cName"]
            //let activeRoosterSheetId = roosterSheetCourseTable[profCourseTable[activeCourseRow]["cName"]!]![activeRoosterSheetRow]["rSheetId"]
            
            
            //stdRecordsTable[activeRoosterSheetId!]!.removeAtIndex(indexPath.row)
            
            //fixme remove student sheets under this rooster sheet index using for loop
            
            let activeStdSheetId = roosterSheetCourseTable[indexPath.row]["sheetId"]
            
            NSUserDefaults.standardUserDefaults().removeObjectForKey("\(activeCourseId!)\(activeStdSheetId!)stdRecordsTable")
            
            
            roosterSheetCourseTable.removeAtIndex(indexPath.row)
            //profCourseTable.removeAtIndex(indexPath.row)
            //NSUserDefaults.standardUserDefaults().setObject(profTableArray, forKey: "profTableArray" )
            NSUserDefaults.standardUserDefaults().setObject(roosterSheetCourseTable, forKey: "\(activeCourseId!)roosterSheetCourseTable" )
            //NSUserDefaults.standardUserDefaults().setObject(roosterSheetCourseTable, forKey: "roosterSheetCourseTable" )
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
