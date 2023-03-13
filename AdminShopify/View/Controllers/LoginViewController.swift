//
//  LoginViewController.swift
//  AdminShopify
//
//  Created by Ahmad Ayman Mansour on 27/02/2023.
//

import UIKit

class LoginViewController: UIViewController {


    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        passwordTextField.delegate = self
        
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        let TBVC = storyboard?.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
        //"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"
        if passwordTextField.text == "0000" {
            self.navigationController?.pushViewController(TBVC, animated: true)
        }else{
            let alert : UIAlertController = UIAlertController(title: "Invalid", message: "Please Enter The Password Again", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "OK!", style: .cancel, handler: nil))
            self.present(alert, animated: true , completion: nil)
        }
    }

}


extension  LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passwordTextField.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if passwordTextField.text != "" {
            return true
        } else {
            passwordTextField.placeholder = "Type something"
            return false
        }
    }
   
}

