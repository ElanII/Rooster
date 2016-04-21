//
//  PCViewController.swift
//  Rooster
//
//  Created by raja adabala on 11/2/15.
//  Copyright © 2015 rajaadabala. All rights reserved.
//

import UIKit


class PCViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var courseNameText: UITextField!
    
    @IBOutlet var errorText: UILabel!
    @IBOutlet var courseNumText: UITextField!
    @IBAction func CreateCourseButton(sender: AnyObject) {
        let courseName:String = courseNameText.text ?? ""
        let courseNum:Int? = Int(courseNumText.text!)
        if courseName == "" || courseNum == nil {
            errorText.text = "Please enter values for Course Name and Course Number"
        } else {
        
            log("New Course \(courseName) \(courseNum!)")
            //let course = courseDetails(courseId: courseNum!, courseName: courseName)
            profCourseTable.append(["courseName" : courseName, "courseNum" : "\(courseNum!)"])
            //profTable.append(course)
            NSUserDefaults.standardUserDefaults().setObject(profCourseTable, forKey: "profCourseTable")
            //NSUserDefaults.standardUserDefaults().setObject(profTableArray, forKey: "profTableArray")
            //NSUserDefaults.standardUserDefaults().setO
            self.navigationController?.popViewControllerAnimated(true)
    
        }
    }
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
