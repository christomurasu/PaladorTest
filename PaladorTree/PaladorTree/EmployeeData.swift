//
//  EmployeeData.swift
//  PaladorTree
//
//  Created by PCCWS - User on 3/9/22.
//

import Foundation
import SwiftyJSON

struct EmployeeData {
    let employeeId: Int
    let name: String
    let managerId: Int
    var depth: Int = 0
    var showName: String = ""
    
    init(dictionary: JSON) {
        employeeId = dictionary["employeeId"].intValue
        name = dictionary["name"].stringValue
        managerId = dictionary["managerId"].intValue
    }
}
