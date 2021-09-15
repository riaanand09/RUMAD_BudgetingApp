//
//  MyAlertsViewController.swift
//  RUMAD_BudgetingApp
//
//  Created by Ria Anand on 8/4/21.
//

import UIKit

class MyAlertsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var myAlertsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myAlertsTableView.delegate = self
        myAlertsTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alerts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        cell.textLabel!.text = alerts[indexPath.row]
        
        return cell
        
    }

}
