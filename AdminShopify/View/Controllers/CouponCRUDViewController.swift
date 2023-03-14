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
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var updatedAtLabel: UILabel!
    
    
    var coupon : Discount?
    var priceRuleID : Int?
    var parameters : [String : Any]?
    var priceRules : [price_rule]?
    var NetworkViewModel : NetworkingViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkViewModel = NetworkingViewModel()
        self.setCouponData()
        
        couponCodeTextField.delegate = self
       
        
    }
    
    @IBAction func uploadButton(_ sender: UIButton) {
        if (couponCodeTextField.text != nil){
            let parameters : [String:Any] = ["discount_code": ["code": couponCodeTextField.text]]
            if (coupon == nil) {
                print("Add")
                let url = "\(NetworkServices.base_url)price_rules/\(priceRuleID ?? 0)/discount_codes.json"
                print(url)
                NetworkServices.post(parameters: parameters, stringUrl: url)
            }else{
                print("update")
                let url = "\(NetworkServices.base_url)price_rules/\(coupon?.price_rule_id ?? 0)/discount_codes/\(coupon?.id ?? 0)"
                print(url)
                NetworkServices.edit(parameters: parameters, stringUrl: url)
            }
        } else {
            let alert = UIAlertController(title: "ERROR", message: "Invalid Data", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        self.dismiss(animated: true)
    }
    
    
    func setCouponData() {
        couponCodeTextField.text = coupon?.code ?? ""
        usageCountLabel.text = "Usage count: \(coupon?.usage_count ?? 0)"
        createdAtLabel.text = "Created at: \(coupon?.created_at ?? "" )"
        updatedAtLabel.text = "Update at:\(coupon?.updated_at ?? "")"
    }
}

extension CouponCRUDViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        couponCodeTextField.endEditing(true)
    return true
    }
}
