//
//  HomeViewController.swift
//  RUMAD_BudgetingApp
//
//  Created by Ria Anand on 8/2/21.
//

import UIKit

public struct Transaction {
    
    public var date = Date()
    public var category = Category()
    public var amount = 0.0
}

public struct Budget {
    
    public var startDate = Date()
    public var endDate = Date()
    public var spendingLimit = 0.0
    public var moneySpent = 0.0
    
}

public struct Category {
    
    public var categoryName = ""
    public var isPositive = false
    
}

public var housing = Category(categoryName: "Housing", isPositive: false)
public var transportation = Category(categoryName: "Transportation", isPositive: false)
public var food = Category(categoryName: "Food", isPositive: false)
public var utilities = Category(categoryName: "Utilities", isPositive: false)
public var insurance = Category(categoryName: "Insurance", isPositive: false)
public var medical = Category(categoryName: "Medical", isPositive: false)
public var savingAndInvesting = Category(categoryName: "Saving and Investing", isPositive: false)
public var personalSpending = Category(categoryName: "Personal Spending", isPositive: false)
public var entertainment = Category(categoryName: "Entertainment", isPositive: false)
public var otherSpent = Category(categoryName: "Other", isPositive: false)
public var salary = Category(categoryName: "Salary", isPositive: true)
public var otherEarned = Category(categoryName: "Other", isPositive: true)

public var allTransactions = [Transaction]()
public var allBudgets = [String: Budget]()
public var alerts = [String]()
public var balance = 0.0

public let categories = [housing, transportation, food, utilities, insurance, medical, savingAndInvesting, personalSpending, entertainment, otherSpent, salary, otherEarned]

class HomeViewController: UIViewController {
    
    @IBOutlet weak var currentBalanceTextView: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currentBalanceTextView.text = "$\(String(format: "%.2f", balance))"
    }
    
    @IBAction func didTapRefresh(_ sender: Any) {
        
        super.loadView()
        currentBalanceTextView.text = "$\(String(format: "%.2f", balance))"
        
    }

}

