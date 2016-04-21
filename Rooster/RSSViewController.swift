//
//  RSSViewController.swift
//  Rooster
//
//  Created by raja adabala on 11/2/15.
//  Copyright © 2015 rajaadabala. All rights reserved.
//

import UIKit
import CoreLocation

// = minor no , name , attendance
//NSUserDefaults.standardUserDefaults().objectForKey("\(activeCourseRow)roosterSheetCourseTable")
//var stdRecordsTable:[Dictionary<String, String>] = []

class RSSViewController: UIViewController, CLLocationManagerDelegate {
    //let activeCourseId = profCourseTable[activeCourseRow]["cName"]
    
    var activeStdSheetId:String = ""
    //let activeCourseId = profTable[activeCourseRow].courseId
    //let activeCourseName = profTable[activeCourseRow].courseName
    //var roosterSheetCourseTable = profCourseTable[activeCourseRow]
    let activeCourseId = profCourseTable[activeCourseRow]["courseNum"]
    let activeCourseName = profCourseTable[activeCourseRow]["courseName"]
    var activeCourse: NSNumber = 0
    var startListening:Bool = true
    //var roosterSheetCourseTable = profTable[activeCourseRow].sheets
    //var stdRecordsTable: [studentsSheet]
    let locationManager = CLLocationManager()
    //var region: CLBeaconRegion
    
    var region: CLBeaconRegion!
    //let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: profId)!, identifier: profTable[activeCourseRow].courseName)
    var inc:Int = 0
    
    var queue:[NSNumber] = []
    var dic:Dictionary<NSNumber, String> = [:]
    
    let colors = [
        1000: UIColor(red: 84/255, green: 77/255, blue: 160/255, alpha: 1),
        1002: UIColor(red: 142/255, green: 212/255, blue: 220/255, alpha: 1),
        1003: UIColor(red: 162/255, green: 213/255, blue: 181/255, alpha: 1),
        9999: UIColor(red: 0/255, green: 128/255, blue: 0/255, alpha: 1)
    ]
    
    let bColors = [
        "red": UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1),
        "green": UIColor(red: 0/255, green: 128/255, blue: 0/255, alpha: 1),
    ]
    
    var rSheetId: String = ""
    var rSheetDate: String = ""

    @IBOutlet var proLabel: UILabel!
    @IBOutlet var courseLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var startLabel: UIButton!
    
    @IBOutlet var resultLabel: UILabel!
    
    @IBAction func StartReceiver(sender: AnyObject) {
        if startListening == true {
            log()
            
            let date = NSDate()
            rSheetId = String(date.hash)
            activeStdSheetId = rSheetId
            rSheetDate = String(date)
            //let sheet = courseSheet(sheetId: rSheetId, sheetName: rSheetDate)
            //stdRecordsTable = sheet.students
            //roosterSheetCourseTable.append(sheet)
            //log ("\(roosterSheetCourseTable.last)")
            roosterSheetCourseTable.append(["sheetId": rSheetId, "sheetName": rSheetDate])
            log ("\(roosterSheetCourseTable.last)")
            
            //let stdRecordsTable = roosterSheetCourseTable[activeTotalSheets].students
            
            locationManager.startRangingBeaconsInRegion(region)
            
            startLabel.setTitle("Stop", forState: .Normal)
            startLabel.backgroundColor = bColors["red"]!
            startListening = false
        } else {
            log()
            locationManager.stopRangingBeaconsInRegion(region)
            
            //let stdRecordsTable = roosterSheetCourseTable[activeTotalSheets].students
            if stdRecordsTable.isEmpty == false {
                log("stdRecordsTable: \(stdRecordsTable)")
            } else {
                stdRecordsTable.append(["stdId" : "NoId", "stdName" : "No Students Found in Class"])
                log("Writing no student values to stdRecordsTable")
            }
            NSUserDefaults.standardUserDefaults().setObject(roosterSheetCourseTable,
                forKey: "\(activeCourseId!)roosterSheetCourseTable")
            log("Saved \(activeCourseId!)roosterSheetCourseTable")
            
            NSUserDefaults.standardUserDefaults().setObject(stdRecordsTable,
                forKey: "\(activeCourseId!)\(activeStdSheetId)stdRecordsTable")
            log("Saved \(activeCourseId!)\(activeStdSheetId)stdRecordsTable")
            //NSUserDefaults.standardUserDefaults().setObject(roosterSheetCourseTable, forKey: "roosterSheetCourseTable")
            self.navigationController?.popViewControllerAnimated(true)
            startLabel.setTitle("Start", forState: .Normal)
            startLabel.backgroundColor = bColors["green"]!
            startListening = true
        }
        
    }
    
    @IBAction func StopReceiver(sender: AnyObject) {
        
        log()
        locationManager.stopRangingBeaconsInRegion(region)
        
        //let stdRecordsTable = roosterSheetCourseTable[activeTotalSheets].students
        if stdRecordsTable.isEmpty == false {
            log("stdRecordsTable: \(stdRecordsTable)")
        } else {
            stdRecordsTable.append(["stdId" : "NoId", "stdName" : "No Students Found in Class"])
            log("Writing no student values to stdRecordsTable")
        }
        NSUserDefaults.standardUserDefaults().setObject(roosterSheetCourseTable,
            forKey: "\(activeCourseId!)roosterSheetCourseTable")
        log("Saved \(activeCourseId!)roosterSheetCourseTable")
        
        NSUserDefaults.standardUserDefaults().setObject(stdRecordsTable,
            forKey: "\(activeCourseId!)\(activeStdSheetId)stdRecordsTable")
        log("Saved \(activeCourseId!)\(activeStdSheetId)stdRecordsTable")
        //NSUserDefaults.standardUserDefaults().setObject(roosterSheetCourseTable, forKey: "roosterSheetCourseTable")
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        log("\(activeCourseId) \(activeCourseName)")
        proLabel.text = "Pro UUID: \(profId)"
        courseLabel.text = "CourseID: \(activeCourseId!) CourseName: \(activeCourseName!)"
        startLabel.setTitle("Start", forState: .Normal)
        startLabel.backgroundColor = bColors["green"]!
        startListening = true
        
        activeCourse = NSNumber(integer: Int(activeCourseId!)!)
        
        let majorValue = CLBeaconMajorValue(activeCourseId!)!
        region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: profId)!, major: majorValue, identifier: profCourseTable[activeCourseRow]["courseName"]!)
        
        //if roosterSheetCourseTable[0]
        
        //region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: profId)!, identifier: activeCourseName)
        //activeClassRooster = "\(activeCourseId)\(activeRoosterSheetId)"

        // Do any additional setup after loading the view.

        /*
        rSheetDate = String(date)
        let sheet = courseSheet(sheetId: rSheetId, sheetName: rSheetDate)
        roosterSheetCourseTable.append(sheet)
        log ("\(roosterSheetCourseTable.last)")
        
        student = roosterSheetCourseTable
        */
        
        /*
        if NSUserDefaults.standardUserDefaults().objectForKey("\(activeCourseId)roosterSheetCourseTable") != nil {
            roosterSheetCourseTable = NSUserDefaults.standardUserDefaults().objectForKey("\(activeCourseId)roosterSheetCourseTable") as! [Dictionary<String, String>]
            if roosterSheetCourseTable.isEmpty {
                log("roosterSheetCourseTable is empty ")
            }
        } else {
            log("roosterSheetCourseTable does not exists in NSUserDefaults")
        }
        */
        
        locationManager.delegate = self
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization()
        }
        
    }

    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        
        //Processing Becon Emmitters and
        
        print("active course \(activeCourse)")
        print(beacons)
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown }
        if (knownBeacons.count > 0) {
            //let closestBeacon = knownBeacons[0] as CLBeacon
            for closestBeacon in knownBeacons {
                if activeCourse == closestBeacon.major {
                    
                    let stdId = closestBeacon.minor
                    
                    print("Student ID \(stdId)")
                    
                    if !queue.contains(stdId) {
                        queue.append(stdId)
                        //let stdName:String = "StudentID: \(++inc)"
                        let stdName:String = "StudentID: \(stdId)"
                        
                        print("Student ID \(stdId) \(stdName)")
                        dic[stdId] = stdName
                        print("Queue \(queue)")
                        
                        // let dic = [ "stdId" :  String(stdId) ]
                        // let obj = stdRecordsTable [activeRoosterSheetId]
                        
                        //let student = studentsSheet(stdId: stdId, stdName: stdName)
                        //var stdRecordsTable = roosterSheetCourseTable[activeTotalSheets + 1].students
                        
                        stdRecordsTable.append(["stdId" : String(stdId), "stdName" : stdName])
                        resultLabel.text = "Students: \(stdRecordsTable.count)"
                        
                        
                        /*
                        if ((stdRecordsTable[activeRoosterSheetId]?.isEmpty) != nil) {
                        stdRecordsTable[activeRoosterSheetId]!.append([ "stdId" :  String(stdId)])
                        } else {
                        //fixme
                        //   stdRecordsTable[activeRoosterSheetId] = [ "stdId" :  String(stdId)]
                        }
                        */
                        // stdRecordsTable.append(["stdId" : String(stdId)])
                        log("student records \(stdRecordsTable.last)")
                        log("Students Count: \(stdRecordsTable.count)")
                        let color = CGFloat(Int(stdId) % 255)
                        if closestBeacon.minor != 0 {
                            self.view.backgroundColor = UIColor(red: color/255, green: color/255, blue: color/255, alpha: 1)
                        } else {
                            self.view.backgroundColor = self.colors[9999]
                        }
                    }
                }
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
