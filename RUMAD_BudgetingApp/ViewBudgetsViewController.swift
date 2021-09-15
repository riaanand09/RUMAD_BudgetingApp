//
//  ViewBudgetsViewController.swift
//  RUMAD_BudgetingApp
//
//  Created by Ria Anand on 8/20/21.
//

import UIKit

class ViewBudgetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var budgetTableView: UITableView!
    @IBOutlet weak var deleteBudgetButton: UIButton!
    @IBOutlet weak var moneySpentTextView: UITextView!
    
    var selectedCellIndex = 0
    
    var budgetCategories = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        budgetTableView.delegate = self
        budgetTableView.dataSource = self
        budgetCategories = Array(allBudgets.keys)
        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allBudgets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let currentCategory = budgetCategories[indexPath.row]
        let currentBudget = allBudgets[currentCategory]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let budgetEndDate = currentBudget!.endDate
        let budgetEndDateString = dateFormatter.string(from: budgetEndDate)
        let budgetSpendingLimit = currentBudget!.spendingLimit
        let budgetMoneySpent = currentBudget!.moneySpent
            
        cell.textLabel!.text = "Budget of $\(String(format: "%.2f", budgetSpendingLimit)) on '\(currentCategory)' until \(budgetEndDateString)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
             didSelectRowAt indexPath: IndexPath) {
        
        self.enableDeleteBudgetButton()
        selectedCellIndex = indexPath.row
        var currentCategory = budgetCategories[indexPath.row]
        var moneySpent = allBudgets[currentCategory]!.moneySpent
        
        moneySpentTextView.text = "You have spent $\(String(format: "%.2f", moneySpent)) towards '\(currentCategory)' so far"
    }
    
    @IBAction func didTapDeleteBudgetButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Delete Transaction?", message: "Are you sure you want to continue? This action cannot be undone.", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { (action: UIAlertAction!) in
            
            let currentCategory = self.budgetCategories[self.selectedCellIndex]
            allBudgets.removeValue(forKey: currentCategory)
            self.budgetCategories.remove(at: self.selectedCellIndex)
            self.disableDeleteBudgetButton()
            self.moneySpentTextView.text = ""
            self.budgetTableView.reloadData()
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
              
        }))

        present(alert, animated: true, completion: nil)
        
    }
    
    func enableDeleteBudgetButton(){
        
        self.deleteBudgetButton.isEnabled = true
        self.deleteBudgetButton.backgroundColor = UIColor.black
        
    }
    
    func disableDeleteBudgetButton(){
        
        self.deleteBudgetButton.isEnabled = false
        self.deleteBudgetButton.backgroundColor = UIColor.systemGray4
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
