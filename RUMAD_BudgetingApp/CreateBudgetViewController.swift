//
//  CreateBudgetViewController.swift
//  RUMAD_BudgetingApp
//
//  Created by Ria Anand on 8/4/21.
//

import UIKit

class CreateBudgetViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var spendingLimitTextField: UITextField!
    
    var selectedCategoryString = ""
    var selectedEndDate = Date()
    var enteredSpendingLimit = 0.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        endDatePicker.datePickerMode = .date
        endDatePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return (categories.count-2)
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row].categoryName
    }
    
    // Capture the picker view selection
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
     
        selectedCategoryString = categories[row].categoryName
    
    }
    
    @IBAction func didTapAddBudget(_ sender: Any) {
        
        selectedCategoryString = categories[categoryPicker.selectedRow(inComponent: 0)].categoryName
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        selectedEndDate = endDatePicker.date
            
        if let amount = Double(spendingLimitTextField.text!) {
            
            enteredSpendingLimit = amount
            
            var newBudget = Budget()
            newBudget.spendingLimit = self.enteredSpendingLimit
            newBudget.endDate = self.selectedEndDate
                
            allBudgets[selectedCategoryString] = newBudget
                
            let alert = UIAlertController(title: "Budget added successfully", message: "You have set a budget to limit your spending towards '\(selectedCategoryString)' under $\(String(format: "%.2f", enteredSpendingLimit)) until \(dateFormatter.string(from: selectedEndDate)).", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

                self.present(alert, animated: true, completion: nil)
        
        }
        else{
            
            let alert = UIAlertController(title: "Error", message: "Please enter a valid value for the spending limit.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }
    }
}
