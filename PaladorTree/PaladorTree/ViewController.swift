//
//  ViewController.swift
//  PaladorTree
//
//  Created by PCCWS - User on 3/9/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let loader = DataLoader()
    let viewModel = ViewModel()
    var employeeData: [EmployeeData] = []
    @IBOutlet weak var textField: UITextField!
    var resultEmployeeData: [EmployeeData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "EmployeeTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        if let data = loader.readLocalFile(forName: "organization-tree") {
            viewModel.parse(jsonData: data)
            self.employeeData = viewModel.processData()
            resultEmployeeData = employeeData
            tableView.reloadData()
        }
    }
    
    @IBAction func btnSearch(_ sender: UIButton) {
        let name = textField.text ?? ""
        if name != "" {
            let arrEmployee = employeeData.filter { $0.name.lowercased().contains(name.lowercased()) }
            resultEmployeeData = arrEmployee
        } else if name == "" {
            resultEmployeeData = employeeData
        }
        
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! EmployeeTableViewCell
        cell.nameLabel.text = resultEmployeeData[indexPath.row].showName
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resultEmployeeData.count
    }
}
