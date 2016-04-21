//
//  RCIViewController.swift
//  Rooster
//
//  Created by raja adabala on 11/2/15.
//  Copyright © 2015 rajaadabala. All rights reserved.
//

import UIKit

class RCIViewController: UIViewController {
    
    @IBOutlet var profUIDText: UITextField!
    
    @IBOutlet var stdCourseNumText: UITextField!
    
    @IBOutlet var stdSIDText: UITextField!
    @IBOutlet var stdCourseNameText: UITextField!
    
    @IBAction func registerButton(sender: AnyObject) {
        let profUId:String = profUIDText.text ?? ""
        let stdCourseNum:String = stdCourseNumText.text ?? ""
        let stdSId:String = stdSIDText.text ?? ""
        let stdCourseName:String = stdCourseNameText.text ?? ""
        
        
        if profUId == "" || stdCourseNum == "" || stdSId == "" || stdCourseName == "" {
            errorLabel.text = "Please enter proper values for All fields"
        } else {
            
            print("Student Registering to New Course \(profUId) \(stdCourseNum) \(stdSId) \(stdCourseName)")
            
            stdCourseTable.append(["profUId" : profUId, "stdCourseNum" : stdCourseNum, "stdSId" : stdSId, "stdCourseName" : stdCourseName])
            
            NSUserDefaults.standardUserDefaults().setObject(stdCourseTable, forKey: "stdCourseTable")
            self.navigationController?.popViewControllerAnimated(true)
            
        }
        
    }
    
    @IBOutlet var errorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShoudReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
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
