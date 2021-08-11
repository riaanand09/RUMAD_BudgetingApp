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
        transactionTableView.delegate = self
        transactionTableView.dataSource = self
        currentBalanceTextView.text = "\(balance)"
        self.disableDeleteTransactionButton()
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTransactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        var transactionDate = allTransactions[indexPath.row].date
        var transactionDateString = dateFormatter.string(from: transactionDate)
        var transactionCategory = allTransactions[indexPath.row].category
        var transactionAmount = allTransactions[indexPath.row].amount
        
        if allTransactions[indexPath.row].isPositive {
            
            cell.textLabel!.text = "+ $\(transactionAmount) on \(transactionDateString)"
            
        }
        else{
            
            cell.textLabel!.text = "- $\(transactionAmount) towards '\(transactionCategory)' on \(transactionDateString)"
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
            
            if allTransactions[self.selectedCellIndex].isPositive {
                balance = balance - allTransactions[self.selectedCellIndex].amount
            }
            else{
                balance = balance + allTransactions[self.selectedCellIndex].amount
            }
            
            self.currentBalanceTextView.text = "\(balance)"
            
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
