//
//  CouponCRUDViewController.swift
//  AdminShopify
//
//  Created by Ahmad Ayman Mansour on 25/02/2023.
//

import UIKit

class CouponCRUDViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var usageCountLabel: UILabel!
    @IBOutlet weak var couponCodeTextField: UITextField!
    @IBOutlet weak var priceRuleSegmentOutlet: UISegmentedControl!
    
    var coupon : Discount?
    var priceRuleID : Int?
    var parameters : [String : Any]?
    var priceRules : [price_rule]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setCouponData()
        
    }
    
    @IBAction func priceRuleValue(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0 :
            priceRuleID = 1383128629552
        case 1 :
           priceRuleID = 1383402504496
        case 2 :
            priceRuleID = 1383131644208
        case 3 :
            let alert = UIAlertController(title: "Add Price Rule", message: "", preferredStyle: .alert)
            alert.addTextField{ (textField) in
                textField.placeholder = "Title"
            }
            alert.addTextField{ (textField) in
                textField.placeholder = "value (0 - 100)"
            }
           
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                self.parameters = [
                    "price_rule": [
                        "title": "\(alert.textFields?[1].text ?? "0")% off all products",
                        "target_type": "line_item",
                        "target_selection": "all",
                        "allocation_method": "across",
                        "value_type": "percentage",
                        "value": "-\(alert.textFields?[0].text ?? "1")",
                        "customer_selection": "all",
                        "starts_at": "2023-03-05T12:00:00-04:00",
                        "ends_at": "2023-03-06T12:00:00-04:00"
                    ]
                ]
                for pr in self.priceRules ?? [] {
                    if pr.value == "-\(alert.textFields?[0].text ?? "")"  {
                        self.priceRuleID = pr.id
                    }
                }
                let url = "\(NetworkServices.base_url)price_rules.json"
                NetworkServices.post(parameters: self.parameters ?? [:], stringUrl: url)
                
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
                    
        default :
            break
        }
    }
    
    
    @IBAction func uploadButton(_ sender: UIButton) {
        if (couponCodeTextField.text != nil){
            
            let parameters : [String:Any] = ["discount_code": ["code": couponCodeTextField.text]]
            print("parameters")
            if (coupon == nil) {
                print("Add")
                let url = "\(NetworkServices.base_url)price_rules/\(priceRuleID ?? 0)/discount_codes.json"
                print(url)
                NetworkServices.post(parameters: parameters, stringUrl: url)
            }else{
                print("update")
                let url = "\(NetworkServices.base_url)price_rules/\(priceRuleID ?? 0)/discount_codes/\(coupon?.id ?? 0)"
                NetworkServices.edit(parameters: parameters, stringUrl: url)
            }
        } else {
            print("Invalid Data!")
        }
        self.dismiss(animated: true)
    }
    
    
    

    func setCouponData() {
        couponCodeTextField.text = coupon?.code ?? ""
        usageCountLabel.text = String(coupon?.usage_count ?? 0)
        switch coupon?.price_rule_id {
        case 1383128629552 :
            priceRuleSegmentOutlet.selectedSegmentIndex = 0
        case 1383402504496 :
            priceRuleSegmentOutlet.selectedSegmentIndex = 1
        case 1383131644208 :
            priceRuleSegmentOutlet.selectedSegmentIndex = 2
        default:
            break
        }
    }
   
}
