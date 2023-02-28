//
//  ProductCRUDViewController.swift
//  AdminShopify
//
//  Created by Ahmad Ayman Mansour on 25/02/2023.
//

import UIKit

class ProductCRUDViewController: UIViewController {

    @IBOutlet weak var productTitleTextField: UITextField!
    @IBOutlet weak var productVendorTextField: UITextField!
    @IBOutlet weak var productPriceTextField: UITextField!
    @IBOutlet weak var actionButtonOutlet: UIButton!
    @IBOutlet weak var inventoryTextField: UITextField!
    @IBOutlet weak var productImageUrlTextField: UITextField!
    
    var product : Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productTitleTextField.text = product?.title ?? ""
        productVendorTextField.text = product?.vendor ?? ""
        productPriceTextField.text = product?.variants[0].price ?? "0"
        inventoryTextField.text = String(product?.variants[0].inventory_quantity ?? 0)
        productImageUrlTextField.text = product?.image.src ?? ""

    }
    
    
    @IBAction func actionButton(_ sender: UIButton) {
        
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
