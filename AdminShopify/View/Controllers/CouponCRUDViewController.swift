//
//  CouponCRUDViewController.swift
//  AdminShopify
//
//  Created by Ahmad Ayman Mansour on 25/02/2023.
//

import UIKit

class CouponCRUDViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var usageCountLabel: UILabel!
    @IBOutlet weak var appliesToTextField: UITextField!
    @IBOutlet weak var percentageTextField: UITextField!
    @IBOutlet weak var couponCodeTextField: UITextField!
    
    var coupon : Discount?
    var menu : UIMenu?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        couponCodeTextField.text = coupon?.code ?? ""
        usageCountLabel.text = String(coupon?.usage_count ?? 0) 
        
        
        
        
    }
    

    
    @IBAction func uploadButton(_ sender: UIButton) {
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
