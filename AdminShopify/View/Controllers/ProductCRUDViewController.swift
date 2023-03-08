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
    @IBOutlet weak var productImageView: UIImageView!
    
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
            
            let parameters : [String:Any] = ["product": ["title": productTitleTextField.text ?? "", "vendor": productVendorTextField.text ?? "" ,"variants" : [["inventory_quantity":Int(inventoryTextField.text ?? "0") ?? 0 ,"price":productPriceTextField.text ?? "0"]],"product_type":productTypeTextField.text ?? "","images":[["src":productImageUrlTextField.text ?? ""]]]]
            
            print("parameters")
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
    }
    
    func checkFunctionalty() {
        if (productTitleTextField.text == ""){
            //actionButtonOutlet.imageView?.image = UIImage(systemName: "plus.square.fill.on.square.fill")
            actionButtonOutlet.setTitle("Add", for: .normal)
           // actionButtonOutlet.backgroundColor = .green
        } else {
           // actionButtonOutlet.backgroundColor = .systemYellow
            actionButtonOutlet.setTitle("Edit", for: .normal)
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
