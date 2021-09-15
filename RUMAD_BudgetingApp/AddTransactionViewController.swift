//
//  AddTransactionViewController.swift
//  RUMAD_BudgetingApp
//
//  Created by Ria Anand on 8/4/21.
//

import UIKit

class AddTransactionViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
    }
    
    var selectedCategory = Category()
    var selectedDate = Date()
    var enteredAmount = 0.00
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if categories[row].isPositive{
            return "\(categories[row].categoryName) (+)"
        }
        else{
            return "\(categories[row].categoryName) (-)"
        }
    }
    
    // Capture the picker view selection
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
     
        selectedCategory = categories[row]
    
    }
    
    @IBAction func didTapAddTransaction(_ sender: Any) {
        selectedCategory = categories[categoryPicker.selectedRow(inComponent: 0)]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        selectedDate = datePicker.date
            
        if let amount = Double(amountTextField.text!) {
            
            enteredAmount = amount
            
            var newTransaction = Transaction()
            newTransaction.amount = self.enteredAmount
            newTransaction.date = self.selectedDate
            newTransaction.category = self.selectedCategory
            allTransactions.append(newTransaction)
            
            if selectedCategory.isPositive {
            
                balance = balance + enteredAmount
                
                let alert = UIAlertController(title: "Transaction added successfully", message: "+ $\(String(format: "%.2f", enteredAmount)) on \(dateFormatter.string(from: selectedDate)). Balance is now $\(String(format: "%.2f", balance))", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                
                
                amountTextField.text = ""
                
            }
            else{
                
                balance = balance - enteredAmount
                
                if allBudgets[selectedCategory.categoryName] == nil {
                    
                    let alert = UIAlertController(title: "Transaction added successfully", message: "- $\(String(format: "%.2f", enteredAmount)) towards '\(selectedCategory.categoryName)' on \(dateFormatter.string(from: selectedDate)). Balance is now $\(String(format: "%.2f", balance))", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                    
                }
                
                else {
                    
                    let budgetStartDate = allBudgets[selectedCategory.categoryName]!.startDate
                    
                    let spendingLimit = allBudgets[selectedCategory.categoryName]!.spendingLimit
                    
                    let prevMoneySpent = allBudgets[selectedCategory.categoryName]!.moneySpent
                    
                    let currentMoneySpent = prevMoneySpent + enteredAmount
                    
                    allBudgets[selectedCategory.categoryName]!.moneySpent = currentMoneySpent
                    
                    if currentMoneySpent >= spendingLimit {
                        
                        alerts.append("Oops! Your budget of $\(String(format: "%.2f", spendingLimit)) on '\(selectedCategory.categoryName)' has been surpassed.")
                        
                        allBudgets.removeValue(forKey: selectedCategory.categoryName)
                        
                        let alert = UIAlertController(title: "Transaction added successfully, but budget surpassed!", message: "You have surpassed your budget of $\(String(format: "%.2f", spendingLimit)) on '\(selectedCategory.categoryName)'. The budget for this category has been cleared; set a new one through the 'add budget' page.", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    else if currentMoneySpent >= spendingLimit*(0.75){
                        
                        alerts.append("Warning: budget of $\(String(format: "%.2f", spendingLimit)) on '\(selectedCategory.categoryName)' is over 75% spent!")
                        
                        let alert = UIAlertController(title: "Transaction added successfully, but budget at least 75% surpassed!", message: "You have spent $\(currentMoneySpent) on '\(selectedCategory.categoryName)' since \(dateFormatter.string(from: budgetStartDate)). This amount is at least 75% of your budget of $\(String(format: "%.2f", spendingLimit))", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        
                        self.present(alert, animated: true, completion: nil)
                        
                        //performSegue(withIdentifier: "sendInfo", sender: self)
                        
                    }
                    
                }
                
            }
            
        }
        else{

            let alert = UIAlertController(title: "Error", message: "Please enter a valid value for the amount.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "sendInfo"{
            
//            vc.transactionDateString = self.selectedDateString
//            vc.transactionCategory = self.selectedCategoryString
//            vc.transactionAmount = self.amount
            
        }
        
    }

}
