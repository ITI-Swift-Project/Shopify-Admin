//
//  LoginViewController.swift
//  AdminShopify
//
//  Created by Ahmad Ayman Mansour on 27/02/2023.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        let TBVC = storyboard?.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
        self.navigationController?.pushViewController(TBVC, animated: true)
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        let SUVC = storyboard?.instantiateViewController(withIdentifier: "signUp") as! SignUpViewController
        self.navigationController?.pushViewController(SUVC, animated: true)
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
