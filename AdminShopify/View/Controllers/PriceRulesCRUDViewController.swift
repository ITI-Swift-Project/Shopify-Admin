//
//  PriceRulesCRUDViewController.swift
//  AdminShopify
//
//  Created by Ahmad Ayman Mansour on 10/03/2023.
//

import UIKit

class PriceRulesCRUDViewController: UIViewController {

    
    
    @IBOutlet weak var titleTextFiled: UITextField!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var startTextField: UITextField!
    @IBOutlet weak var endTextFeild: UITextField!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var updatedAtLabel: UILabel!
    
    var priceRule : price_rule?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setPriceRuleValues()
    }
    
    func setPriceRuleValues(){
        titleTextFiled.text = priceRule?.title
        valueTextField.text = priceRule?.value
        startTextField.text = priceRule?.starts_at
        endTextFeild.text = priceRule?.ends_at
        createdAtLabel.text = "Created at: \(priceRule?.created_at ?? "")"
        updatedAtLabel.text = "Update at: \(priceRule?.updated_at ?? "")"
    }
    
    @IBAction func updateButton(_ sender: UIButton) {
        
        let parameters = [
            "price_rule": [
                "title": "\(titleTextFiled.text ?? "0")",
                "target_type": "line_item",
                "target_selection": "all",
                "allocation_method": "across",
                "value_type": "percentage",
                "value": "-\(valueTextField.text ?? "1")",
                "customer_selection": "all",
                "starts_at": "\(startTextField.text ?? "")",
                "ends_at": "\(endTextFeild.text ?? "")"
            ]
        ]
        
        let url = "\(NetworkServices.base_url)price_rules/\(priceRule?.id ?? 0).json"
        print(url)
        print(parameters)
        NetworkServices.edit(parameters: parameters, stringUrl: url)
        self.dismiss(animated: true)
    }
    

}
