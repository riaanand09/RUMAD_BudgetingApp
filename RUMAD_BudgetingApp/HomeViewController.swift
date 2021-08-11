//
//  HomeViewController.swift
//  RUMAD_BudgetingApp
//
//  Created by Ria Anand on 8/2/21.
//

import UIKit

public struct Transaction {
    
    var isPositive = true
    var date = Date()
    var category = ""
    var amount = 0.0
    
}

public var allTransactions = [Transaction]()
public var balance = 0.0

class HomeViewController: UIViewController {
    
    @IBOutlet weak var currentBalanceTextView: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentBalanceTextView.text = "\(balance)"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapRefresh(_ sender: Any) {
        
        super.loadView()
        currentBalanceTextView.text = "\(balance)"
        
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
