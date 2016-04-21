//
//  ProfData.swift
//  Rooster
//
//  Created by raja adabala on 11/5/15.
//  Copyright © 2015 rajaadabala. All rights reserved.
//

import Foundation

class studentsSheet {
    var stdId: NSNumber
    var stdName: String
    init(stdId: NSNumber, stdName: String) {
        self.stdId = stdId
        self.stdName = stdName
    }
}

/*
table2
row 1 - sheetId = "13444", sheetName = "date"
row 2 - sheetId = "13443", sheetName = "date"
*/

//table 2
class courseSheet {
    var sheetId: Int
    var sheetName: String
    var students:Array<studentsSheet> = []
    
    init(sheetId: Int, sheetName: String) {
        self.sheetId = sheetId
        self.sheetName = sheetName
    }
}

/*
table1
row 1 - courseId = "4102", courseName = "SPL"
row 2 - courseId = "4103", courseName = "SPD"
*/


//table 1
/*
@objc(courseDetails)
class courseDetails : NSObject, NSCoding {
    var courseId: Int
    var courseName: String
    var sheets:Array<courseSheet>
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("profTable")
    
    struct PropertyKey {
        static let courseIdKey = "courseId"
        static let courseNameKey = "courseName"
        static let sheetsKey = "sheets"
    }
    
    @objc init?(courseId: Int, courseName: String, sheets: Array<courseSheet>?) {
        // Initialize stored properties.
        self.courseId = courseId
        self.courseName = courseName
        self.sheets = sheets ?? []
        
        super.init()
        
        // Initialization should fail if there is no name or if the rating is negative.
        if courseName.isEmpty || courseId < 0 {
            return nil
        }
    }
    
    
}
*/


class courseDetails {
var courseId: Int
var courseName: String
var sheets:Array<courseSheet> = []
init(courseId: Int, courseName: String) {
self.courseId = courseId
self.courseName = courseName
}
}


/*
table1->table2->table3
*/
//root table
/*
var profTable:Array<courseDetails> = []

let course = courseDetails(courseId: "4102", courseName: "SPL")
profTable.append(course)

let sheet = courseSheet(sheetId: "1122333", sheetName: "\(String(NSDate()))")
profTable[0].sheets.append(sheet)

let student = studentsSheet(stdId: "1460", stdName: "raja adabala")
profTable[0].sheets[0].students.append(student)

profTable[0].sheets[0].students[0].stdName

*/