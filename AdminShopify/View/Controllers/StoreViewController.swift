//
//  StoreViewController.swift
//  AdminShopify
//
//  Created by Ahmad Ayman Mansour on 25/02/2023.
//

import UIKit

class StoreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func customersButton(_ sender: UIButton) {
        let IVC = storyboard?.instantiateViewController(withIdentifier: "information") as! InformationViewController
        self.present(IVC, animated:true, completion:nil)
    }
    
    @IBAction func analyticsButton(_ sender: Any) {
        let IVC = storyboard?.instantiateViewController(withIdentifier: "information") as! InformationViewController
        self.present(IVC, animated:true, completion:nil)
    }
    @IBAction func settingsButton(_ sender: UIButton) {
        let IVC = storyboard?.instantiateViewController(withIdentifier: "information") as! InformationViewController
        self.present(IVC, animated:true, completion:nil)
    }

    @IBAction func logoutButton(_ sender: UIButton) {
  //        let LVC = storyboard?.instantiateViewController(withIdentifier: "login") as! LoginViewController
  //        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.setRootViewController(LVC)
       // self.navigationController?.popToRootViewController(animated: true)
    }

}
