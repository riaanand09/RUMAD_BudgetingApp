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
    
    let categories = ["Housing (-)", "Transportation (-)", "Food (-)", "Utilities (-)", "Insurance (-)", "Medical (-)", "Saving/Investing (-)", "Personal Spending (-)", "Other (-)", "Salary (+)", "Other (+)"]
    
    var selectedCategory = ""
    var selectedDate = Date()
    var enteredAmount = 0.0
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
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
            
            if selectedCategory == "Salary (+)" || selectedCategory == "Other (+)" {
                
                newTransaction.isPositive = true
                allTransactions.append(newTransaction)
                balance = balance + enteredAmount
                
                let alert = UIAlertController(title: "Transaction added successfully", message: "+ $\(enteredAmount) on \(dateFormatter.string(from: selectedDate)). Balance is now \(balance)", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                
                
                amountTextField.text = ""
                
            }
            else{
                
                newTransaction.isPositive = false
                allTransactions.append(newTransaction)
                balance = balance - enteredAmount
                
                let alert = UIAlertController(title: "Transaction added successfully", message: "- $\(enteredAmount) towards '\(selectedCategory)' on \(dateFormatter.string(from: selectedDate)). Balance is now \(balance)", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                
            }
            
            //performSegue(withIdentifier: "sendInfo", sender: self)
        }
        else{

            let alert = UIAlertController(title: "Error", message: "Please enter a valid value for the amount.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "sendInfo"{
            
//            vc.transactionDateString = self.selectedDateString
//            vc.transactionCategory = self.selectedCategoryString
//            vc.transactionAmount = self.amount
            
//        }
        
//    }

}
