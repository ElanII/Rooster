//
//  ProfTableViewController.swift
//  Rooster
//
//  Created by raja adabala on 11/1/15.
//  Copyright © 2015 rajaadabala. All rights reserved.
//

import UIKit

//var profTable:Array<courseDetails> = []
//var profTableArray:[Array<courseDetails>] = []

var profId:String = ""
var activeCourseRow = -1

var profCourseTable:[Dictionary<String, String>] = []
var roosterSheetCourseTable:[Dictionary<String, String>] = []
var stdRecordsTable:[Dictionary<String, String>]  = []

/*
profCourseTable
row 1 - courseId = "4102", courseName = "SPL"
row 2 - courseId = "4103", courseName = "SPD"
set
NSUserDefaults.standardUserDefaults().setObject(profCourseTable, forKey: "profCourseTable")
get
NSUserDefaults.standardUserDefaults().objectForKey("profCourseTable")

roosterSheetCourseTable
row 1 - sheetId = "13444", sheetName = "date",
row 2 - sheetId = "13443", sheetName = "date"
set
4102roosterSheet
4102roosterSheetCourseTable
NSUserDefaults.standardUserDefaults().setObject(roosterSheetCourseTable, forKey: "\(profCourseTable[profCourseTable.row]["sheetId"])roosterSheetCourseTable\(roosterSheetCourseTable.size)")
get
NSUserDefaults.standardUserDefaults().objectForKey("\(profCourseTable[profCourseTable.row]["sheetId"])roosterSheetCourseTable\(roosterSheetCourseTable.currentrow)")

//this is not required
stdRecordsTable
row 1 - stdId = "13444", stdName = "date"
row 2 - stdId = "13443", stdName = "date"
set
4102roosterSheetCourseTable00
4102roosterSheetCourseTable10
NSUserDefaults.standardUserDefaults().setObject(roosterSheetCourseTable, forKey: "\(profCourseTable[profCourseTable.row]["sheetId"])roosterSheetCourseTable\(roosterSheetCourseTable.size)")
get
NSUserDefaults.standardUserDefaults().objectForKey("\(profCourseTable[profCourseTable.row]["sheetId"])roosterSheetCourseTable\(roosterSheetCourseTable.currentrow)")
*/


//var profCourseTable:[Dictionary<String, String>] = []
//var roosterSheetCourseTable:[String : [Dictionary<String, String>] ] = [:]
//var stdRecordsTable:[String : [Dictionary<String, String>] ] = [:]


class ProfTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        log()
        super.viewDidLoad()
        activeCourseRow = -1
        
        //activeRoosterSheetRow = -1
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem  = self.editButtonItem()
        
        if NSUserDefaults.standardUserDefaults().objectForKey("profId") != nil {
            profId = NSUserDefaults.standardUserDefaults().objectForKey("profId") as! String
            
            log("Professor unique id is \(profId)")        }
        else {
            profId = NSUUID().UUIDString
            
            log("Professor unique id is \(profId)")
            
            NSUserDefaults.standardUserDefaults().setObject(profId, forKey: "profId")
        }
        
        if NSUserDefaults.standardUserDefaults().objectForKey("profCourseTable") != nil {
            profCourseTable = NSUserDefaults.standardUserDefaults().objectForKey("profCourseTable") as! [Dictionary<String, String>]
            
            if profCourseTable.isEmpty {
                log("profCourseTable is empty ")
            }
        } else {
            log("profCourseTable does not exists in NSUserDefaults")
        }
        
        roosterSheetCourseTable = []
        stdRecordsTable = []
        
        /*
        if NSUserDefaults.standardUserDefaults().objectForKey("profTableArray") != nil {
            let arrayTable = NSUserDefaults.standardUserDefaults().objectForKey("profTableArray") as! [Array<courseDetails>]
            if arrayTable.isEmpty {
                log("profTable is empty ")
            } else {
                profTable = arrayTable.first!
            }
        } else {
            log("profTable does not exists in NSUserDefaults")
        }
        */
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
        
        //return profTable.count
        return profCourseTable.count
    
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProfCourseCell", forIndexPath: indexPath)
        
        
        // Configure the cell...
        //cell.textLabel?.text = profTable[indexPath.row].courseName
        cell.textLabel?.text = profCourseTable[indexPath.row]["courseName"]
        
        return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        activeCourseRow = indexPath.row
        roosterSheetCourseTable = []
        stdRecordsTable = []
       // activeCourseId = profCourseTable[activeCourseRow]["cNum"] ?? ""
        //log("\(activeCourseRow) \(activeCourseId)")
        log("\(activeCourseRow)")
        
        return indexPath
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "newPlace" {
            log("new place")
            activeCourseRow = -1
        }
        log("segue called for ProfTableViewController !")
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            //for var row in roosterSheetCourseTable[profCourseTable[indexPath.row]]
            //stdRecordsTable
            //roosterSheetCourseTable
            //profTable.removeAtIndex(indexPath.row)
            
            let activeCourseId = profCourseTable[indexPath.row]["courseNum"]
            
            
            if NSUserDefaults.standardUserDefaults().objectForKey("\(activeCourseId!)roosterSheetCourseTable") != nil {
                roosterSheetCourseTable = NSUserDefaults.standardUserDefaults().objectForKey("\(activeCourseId!)roosterSheetCourseTable") as! [Dictionary<String, String>]
                if roosterSheetCourseTable.isEmpty {
                    log("\(activeCourseId!)roosterSheetCourseTable is empty ")
                } else {
                    for roosterSheet in roosterSheetCourseTable {
                        let activeStdSheetId = roosterSheet["sheetId"]
                        
                        NSUserDefaults.standardUserDefaults().removeObjectForKey("\(activeCourseId!)\(activeStdSheetId!)stdRecordsTable")
                    }
                }
            } else {
                log("\(activeCourseId!)roosterSheetCourseTabledoes not exists in NSUserDefaults")
            }
            
            
            NSUserDefaults.standardUserDefaults().removeObjectForKey("\(activeCourseId!)roosterSheetCourseTable")

            
            profCourseTable.removeAtIndex(indexPath.row)
            
            //Fixme for loops to delete roostersheets and student sheets before deleting profcourse entry for those.
            NSUserDefaults.standardUserDefaults().setObject(profCourseTable, forKey: "profCourseTable" )
            //NSUserDefaults.standardUserDefaults().removeObjectForKey("profCourseTable")
            
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
