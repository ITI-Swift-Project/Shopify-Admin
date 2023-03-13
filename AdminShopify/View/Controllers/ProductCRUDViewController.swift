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
    @IBOutlet weak var productCategoryTextField: UITextField!
    
    
    var networkViewModel : NetworkingViewModel!
    var product : Product?
    var flag : Bool?
    var productId : Int?
    var categoryParameters : [String : Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkViewModel = NetworkingViewModel()
        self.setTextFieldData()
        self.checkFunctionalty()
        
        
    }
    
    
    @IBAction func checkProductImage(_ sender: UIButton) {
        productImageView.kf.setImage(with: URL(string:productImageUrlTextField.text  ?? "" ),placeholder: UIImage(systemName:"exclamationmark.circle.fill"))
    }
    
    @IBAction func actionButton(_ sender: UIButton) {
        
        if (productTitleTextField.text != "" && productSizeTextFiled.text != ""  && productVendorTextField.text != "" && inventoryTextField.text != "" && productColor.text != "" && productTypeTextField.text != "" && productImageUrlTextField.text != "" && productSizeTextFiled.text != ""){
            let parameters : [String:Any] = ["product": ["title": productTitleTextField.text ?? "",
                                                         "vendor": productVendorTextField.text ?? "" ,
                                                         "variants":[
                                                            ["inventory_quantity":Int(inventoryTextField.text ?? "0") ?? 0 ,
                                                             "price":productPriceTextField.text ?? "0" ,
                                                             "option1": productSizeTextFiled.text!,
                                                             "option2": productColor.text ?? ""]],
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
                let url = "\(NetworkServices.base_url)products.json"
                networkViewModel.post(url: url, paremeters: parameters) { result in
                    switch result {
                    case .success(let data):
                        do {
                            if let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                                if let errors = dict["errors"] as? [String: [String]] {
                                    var message = ""
                                    for (key, value) in errors {
                                        
                                        if let errorMessage = value[0] as? String {
                                            message.append("\(key) : ")
                                            message.append("\(errorMessage)")
                                            message.append("\n")
                                            
                                        }
                                    }
                                    DispatchQueue.main.async {
                                        let alert =  UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                                        let action = UIAlertAction(title: "OK" , style: .default , handler: nil)
                                        alert.addAction(action)
                                        self.present(alert, animated: true, completion: nil)
                                        message = ""
                                        print(message)
                                    }
                                    
                                } else if let pro : [String : Any] = dict["product"] as? [String : Any] {
                                    DispatchQueue.main.async {
                                        
                                        self.productId = pro["id"] as? Int ?? 0
                                        self.categorized(productId: self.productId ?? 0)
                                        NetworkServices.post(parameters: self.categoryParameters ?? [:], stringUrl: "\(NetworkServices.base_url)collects.json")
                                        let alert = UIAlertController(title: "Success", message: "Product Add Successfully", preferredStyle: UIAlertController.Style.alert)
                                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                                            self.dismiss(animated: true)
                                        }))
                                        self.present(alert, animated: true, completion: nil)
                                        
                                    }
                            } else {
                                print("Unknown response")
                            }
                        } else {
                            print("Response is not a dictionary")
                        }
                    } catch {
                        print("Error parsing JSON: \(error.localizedDescription)")
                    }
                case .failure(let error):
                    let alert =  UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK" , style: .default , handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }else{
            let url = "\(NetworkServices.base_url)products/\(product?.id ?? 0)"
            NetworkServices.edit(parameters: parameters, stringUrl: url)
            let alert =  UIAlertController(title: "Done", message: "Product Updated Successfully", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK" , style: .default) { action in
                self.dismiss(animated: true)
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        
    }else{
        let alert = UIAlertController(title: "Faild", message: "Missing Data!" , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancle", style: UIAlertAction.Style.default))
        self.present(alert, animated: true, completion: nil)
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


//MARK: - Add To Category
func categorized(productId: Int){
    let arr = ["Men","Women","Kids","Sale"]
    if self.productCategoryTextField.text != "" && arr.contains(productCategoryTextField.text ?? "") {
        switch self.productCategoryTextField.text {
        case "Men":
            self.categoryParameters = [
                "collect": [
                    "collection_id": 437626929456 ,
                    "product_id":productId,
                    "position":1,
                ]
            ]
            
        case "Women":
            self.categoryParameters = [
                "collect": [
                    "collection_id": 437626962224,
                    "product_id":productId,
                    "position":1,
                ]
            ]
            
        case "Kids":
            self.categoryParameters = [
                "collect": [
                    "collection_id": 437626994992,
                    "product_id": productId,
                    "position": 1,
                ]
            ]
            
        case "Sale":
            self.categoryParameters = [
                "collect": [
                    "collection_id": 437627027760,
                    "product_id":productId,
                    "position":1,
                ]
            ]
            
        default:
            self.categoryParameters = [
                "collect": [
                    "collection_id": 437627027760,
                    "product_id":productId,
                    "position":1,
                ]
            ]
        }
    }else{
        let alert = UIAlertController(title: "Warning", message: "Please ensure that your input in category field is one of the following: 'Men', 'Women', 'Kids', or 'Sale', and that the first letter is capitalized." , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
        self.present(alert, animated: true, completion: nil)
    }
}


}
