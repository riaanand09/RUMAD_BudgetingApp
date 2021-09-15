//
//  ViewTransactionsViewController.swift
//  RUMAD_BudgetingApp
//
//  Created by Ria Anand on 8/4/21.
//

import UIKit

class ViewTransactionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var transactionTableView: UITableView!
    @IBOutlet weak var currentBalanceTextView: UITextField!
    @IBOutlet weak var deleteTransactionButton: UIButton!
    
    var selectedCellIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        transactionTableView.delegate = self
        transactionTableView.dataSource = self
        currentBalanceTextView.text = "$\(String(format: "%.2f", balance))"
        self.disableDeleteTransactionButton()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTransactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let transactionDate = allTransactions[indexPath.row].date
        let transactionDateString = dateFormatter.string(from: transactionDate)
        let transactionCategory = allTransactions[indexPath.row].category
        let transactionAmount = allTransactions[indexPath.row].amount
        
        if transactionCategory.isPositive {
            
            cell.textLabel!.text = "+ $\(String(format: "%.2f", transactionAmount)) on \(transactionDateString)"
            
        }
        else{
            
            cell.textLabel!.text = "- $\(String(format: "%.2f", transactionAmount)) towards '\(transactionCategory.categoryName)' on \(transactionDateString)"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
             didSelectRowAt indexPath: IndexPath) {
        
        self.enableDeleteTransactionButton()
        selectedCellIndex = indexPath.row
    }
    
    @IBAction func didTapDeleteTransactionButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Delete Transaction?", message: "Are you sure you want to continue? This action cannot be undone.", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { (action: UIAlertAction!) in
            
            if allTransactions[self.selectedCellIndex].category.isPositive {
                balance = balance - allTransactions[self.selectedCellIndex].amount
            }
            else{
                balance = balance + allTransactions[self.selectedCellIndex].amount
            }
            
            self.currentBalanceTextView.text = "$\(String(format: "%.2f", balance))"
            
            allTransactions.remove(at: self.selectedCellIndex)
            self.disableDeleteTransactionButton()
            self.transactionTableView.reloadData()
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
              
        }))

        present(alert, animated: true, completion: nil)
        
    }
    
    func enableDeleteTransactionButton(){
        
        self.deleteTransactionButton.isEnabled = true
        self.deleteTransactionButton.backgroundColor = UIColor.black
        
    }
    
    func disableDeleteTransactionButton(){
        
        self.deleteTransactionButton.isEnabled = false
        self.deleteTransactionButton.backgroundColor = UIColor.systemGray4
    }
    
}
