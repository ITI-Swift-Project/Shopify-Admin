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
    @IBOutlet weak var productTypeTextField: UITextField!
    
    var product : Product?
    var flag : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setTextFieldData()
        self.checkFunctionalty()


    }
    

    
    @IBAction func actionButton(_ sender: UIButton) {
        
        if (productTitleTextField.text != nil){
            
            let parameters : [String:Any] = ["product": ["title": productTitleTextField.text , "vendor": productVendorTextField.text ,"variants" : [["inventory_quantity":Int(inventoryTextField.text ?? "0")  ,"price":productPriceTextField.text]],"product_type":productTypeTextField.text,"images":[["src":productImageUrlTextField.text]]]]
            
            print("parameters")
            if (product == nil) {
                print("Add")
                let url = "\(NetworkServices.base_url)products.json"
                NetworkServices.post(parameters: parameters, stringUrl: url)
            }else{
                print("update")
                let url = "\(NetworkServices.base_url)products/\(product?.id ?? 1).json"
                NetworkServices.edit(parameters: parameters, stringUrl: url)
            }
        } else {
            print("Invalid Data!")
        }
        
    }
    
    
    
    //MARK: - Functions
    func setTextFieldData() {
        productTitleTextField.text = product?.title ?? ""
        productVendorTextField.text = product?.vendor ?? ""
        productPriceTextField.text = product?.variants?[0].price ?? "0"
        inventoryTextField.text = String(product?.variants?[0].inventory_quantity ?? 0)
        productImageUrlTextField.text = product?.image?.src ?? ""
        productTypeTextField.text = product?.product_type ?? ""
    }
    
    func checkFunctionalty() {
        if (productTitleTextField.text == nil){
            actionButtonOutlet.imageView?.image = UIImage(systemName: "plus.square.fill.on.square.fill")
            actionButtonOutlet.setTitle("ADD", for: .normal)
            actionButtonOutlet.backgroundColor = .green
        } else {
            actionButtonOutlet.backgroundColor = .systemYellow
            actionButtonOutlet.setTitle("Update", for: .normal)
        }
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
