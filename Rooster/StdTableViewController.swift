//
//  StdTableViewController.swift
//  Rooster
//
//  Created by raja adabala on 11/1/15.
//  Copyright © 2015 rajaadabala. All rights reserved.
//

import UIKit

var stdCourseTable:[Dictionary<String, String>] = []

var stdActiveCourseId = ""
var stdActiveCourseRow = -1

class StdTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if NSUserDefaults.standardUserDefaults().objectForKey("stdCourseTable") != nil {
            stdCourseTable = NSUserDefaults.standardUserDefaults().objectForKey("stdCourseTable") as! [Dictionary<String, String>]
            if stdCourseTable == [] {
                print("stdCourseTable is empty ")
            }
        } else {
            print("stdCourseTable does not exists in NSUserDefaults")
        }

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
        return stdCourseTable.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StdCourseCell", forIndexPath: indexPath)
        
        
        // Configure the cell...
        cell.textLabel?.text = stdCourseTable[indexPath.row]["stdCourseName"]
        return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        stdActiveCourseRow = indexPath.row
        stdActiveCourseId = stdCourseTable[stdActiveCourseRow]["stdCourseNum"] ?? ""
        print ("\(__FUNCTION__) \(__FILE__)")
        print(stdActiveCourseRow)
        print(stdActiveCourseId)
        return indexPath
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "newPlace" {
            print("new place", terminator: "")
            stdActiveCourseRow = -1
        }
        print("segue called for TableViewController !")
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            stdCourseTable.removeAtIndex(indexPath.row)
            NSUserDefaults.standardUserDefaults().setObject(stdCourseTable, forKey: "stdCourseTable" )
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
