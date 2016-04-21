//
//  ViewController.swift
//  Rooster
//
//  Created by raja adabala on 11/1/15.
//  Copyright © 2015 rajaadabala. All rights reserved.
//

import UIKit

func log(message: String = "",
    function: String = __FUNCTION__ ,
    file: String = __FILE__,
    line: Int = __LINE__) {
        print("Message: \"\(message)\" (File: \(file), Function: \(function), Line: \(line))")
}

class ViewController: UIViewController {

    @IBAction func ProfButton(sender: AnyObject) {
        log("ProfButton Clicked!")
    }
    
    @IBAction func StdButton(sender: AnyObject) {
        log("StdButton Clicked!")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

