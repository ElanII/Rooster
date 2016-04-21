//
//  BYPViewController.swift
//  Rooster
//
//  Created by raja adabala on 11/2/15.
//  Copyright © 2015 rajaadabala. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

class BYPViewController: UIViewController, CBPeripheralManagerDelegate {
    let profUId = stdCourseTable[stdActiveCourseRow]["profUId"]
    //stdCourseTable.append(["profUId" : profUId, "stdCourseNum" : stdCourseNum, "stdSId" : stdSId, "stdCourseName" : stdCourseName])
    let major = stdCourseTable[stdActiveCourseRow]["stdCourseNum"]
    let minor = stdCourseTable[stdActiveCourseRow]["stdSId"]
    let courseName = stdCourseTable[stdActiveCourseRow]["stdCourseName"]
    var startCast: Bool = true
    let colors = [
        "red": UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1),
        "green": UIColor(red: 0/255, green: 128/255, blue: 0/255, alpha: 1),
    ]
    
    var region = CLBeaconRegion()
    var data = NSDictionary()
    var manager: CBPeripheralManager!
    
    @IBOutlet var stdCourseLabel: UILabel!
    
    @IBOutlet var buttonTitle: UIButton!
    
    @IBOutlet var bTlabel: UILabel!
    
    @IBAction func startBroadCast(sender: AnyObject) {
        if startCast == true {
            
            if(manager.state == CBPeripheralManagerState.PoweredOn) {
                
                data = region.peripheralDataWithMeasuredPower(nil)
                peripheralManagerDidUpdateState(manager)
                manager.startAdvertising(data as? [String : AnyObject])
                
                buttonTitle.setTitle("Stop", forState: .Normal)
                buttonTitle.backgroundColor = colors["red"]!
                log("Bluetooth powered on")
                log("data: \(self.data)")
                
                bTlabel.text = "Broadcast Started for \(major!)"
                startCast = false
            } else if(manager.state == CBPeripheralManagerState.PoweredOff) {
                log("powered off")
                
                bTlabel.text = "Turn on Bluetooth and Start"
                
            }
            
        } else {
            
            log("Broadcast Stopped")
            
            manager.stopAdvertising()
            
            startCast = true
            bTlabel.text = "Broadcast Stopped for \(major!)"
            buttonTitle.setTitle("Start", forState: .Normal)
            buttonTitle.backgroundColor = colors["green"]!

        }
    }
    
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {
        var notify = ""
        
        switch peripheral.state {
        case CBPeripheralManagerState.PoweredOn:
            notify = "Bluetooth is Turned On"
            
        case CBPeripheralManagerState.PoweredOff:
            if !startCast {
                startBroadCast(self)
            }
            notify = "Bluetooth is Turned Off"
            
        case CBPeripheralManagerState.Resetting:
            notify = "Bluetooth is Resetting"
            
        case CBPeripheralManagerState.Unauthorized:
            notify = "Bluetooth is Not Authorized"
            
        case CBPeripheralManagerState.Unsupported:
            notify = "Bluetooth is Not Supported"
            
        default:
            notify = "Bluetooth Status is Unknown"
        }
        
        bTlabel.text = notify
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CBPeripheralManager(delegate: self, queue: nil, options: nil)
        startCast = true
        stdCourseLabel.text = "\(courseName!)"
        buttonTitle.setTitle("Start", forState: .Normal)
        buttonTitle.backgroundColor = colors["green"]!
        let majorValue = CLBeaconMajorValue(major!)!
        let minorValue = CLBeaconMajorValue(minor!)!
        self.region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: profUId!)! , major: majorValue, minor: minorValue, identifier: courseName!)
        
        // Do any additional setup after loading the view.
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
