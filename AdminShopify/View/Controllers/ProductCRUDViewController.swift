//
//  ProductCRUDViewController.swift
//  AdminShopify
//
//  Created by Ahmad Ayman Mansour on 25/02/2023.
//

import UIKit
import Kingfisher

class ProductCRUDViewController: UIViewController {

    @IBOutlet weak var productTitleTextField: UITextField!
    @IBOutlet weak var productVendorTextField: UITextField!
    @IBOutlet weak var productPriceTextField: UITextField!
    @IBOutlet weak var actionButtonOutlet: UIButton!
    @IBOutlet weak var inventoryTextField: UITextField!
    @IBOutlet weak var productImageUrlTextField: UITextField!
    @IBOutlet weak var productTypeTextField: UITextField!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productColor: UITextField!
    @IBOutlet weak var productSizeTextFiled: UITextField!
    
    var product : Product?
    var flag : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setTextFieldData()
        self.checkFunctionalty()
        

    }
    

    @IBAction func checkProductImage(_ sender: UIButton) {
        productImageView.kf.setImage(with: URL(string:productImageUrlTextField.text  ?? "" ),placeholder: UIImage(systemName:"exclamationmark.circle.fill"))
    }
    
    @IBAction func actionButton(_ sender: UIButton) {
        
        if (productTitleTextField.text != nil){
            
            let parameters : [String:Any] = ["product": ["title": productTitleTextField.text ?? "",
                "vendor": productVendorTextField.text ?? "" ,
                "variants":[
                    ["inventory_quantity":Int(inventoryTextField.text ?? "0") ?? 0 ,
                     "price":productPriceTextField.text ?? "0" ,
                     "option1": productSizeTextFiled.text!,
                     "option2": productColor.text!]],
                     "product_type":productTypeTextField.text ?? "",
                     "images":[["src":productImageUrlTextField.text ?? ""]],
                    "options": [
                    ["name": "Size",
                    "position": 1,
                    "values": [productSizeTextFiled.text!],
                     ],
                    ["name": "Color",
                        "position": 2,
                        "values": [productColor.text!],
                    ]]]]
    
            if (product == nil) {
                print("Add")
                let url = "\(NetworkServices.base_url)products.json"
                NetworkServices.post(parameters: parameters, stringUrl: url)
                self.dismiss(animated: true)
            }else{
                print("update")
                let url = "\(NetworkServices.base_url)products/\(product?.id ?? 1).json"
                NetworkServices.edit(parameters: parameters, stringUrl: url)
                self.dismiss(animated: true)
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
        productImageView.kf.setImage(with: URL(string:product?.image?.src  ?? "" ),placeholder: UIImage(systemName:"exclamationmark.circle.fill"))
        productSizeTextFiled.text = product?.options?[0].values?.first ?? ""
        productColor.text = product?.options?[1].values?.first ?? ""
    }
    
    func checkFunctionalty() {
        if (productTitleTextField.text == ""){
            actionButtonOutlet.setTitle("Add", for: .normal)
        } else {
            actionButtonOutlet.setTitle("Edit", for: .normal)
        }
    }

}
