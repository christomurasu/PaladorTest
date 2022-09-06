//
//  ViewModel.swift
//  PaladorTree
//
//  Created by PCCWS - User on 3/9/22.
//

import Foundation
import SwiftyJSON

class ViewModel {
    
    var employeeData: [EmployeeData] = []
    
    func parse(jsonData: Data) {
        do {
            let jsonObj = try JSON(data: jsonData)
            parseData(json: jsonObj)
        } catch {
            print("decode error")
        }
    }
    
    func parseData(json: JSON) {
        let array = json.arrayValue
        for item in array {
            let data = EmployeeData.init(dictionary: item)
            employeeData.append(data)
        }
    }
    
    func processData() -> [EmployeeData] {
        var sortedEmployee: [EmployeeData] = []
        foo(&employeeData, &sortedEmployee)
        print(sortedEmployee)
        return sortedEmployee
    }
    
    func foo( _ remainingEmployee: inout [EmployeeData], _ sortedEmployee: inout [EmployeeData], _ managerId: Int? = 0, _ depth: Int = 0) {
        let children = remainingEmployee.filter { $0.managerId == managerId }
        for child in children {
            var childAppend = child
            childAppend.depth = depth
            let padding = String(repeating: (" " as Character), count: 4*depth)
            childAppend.showName = padding+childAppend.name
            sortedEmployee.append(childAppend)
            foo(&remainingEmployee, &sortedEmployee, child.employeeId, depth+1)
        }
        remainingEmployee = remainingEmployee.filter { $0.managerId != managerId }
    }
}
