//
//  StoreViewController.swift
//  AdminShopify
//
//  Created by Ahmad Ayman Mansour on 25/02/2023.
//

import UIKit

class StoreViewController: UIViewController {

    @IBOutlet weak var customersCollecctionView: UICollectionView!
    
    var NetworkViewModel : NetworkingViewModel!
    var customerArray : [Customer]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customersCollecctionView.delegate = self
        customersCollecctionView.dataSource = self
        customersCollecctionView.register(CustomerCollectionViewCell.nib(), forCellWithReuseIdentifier: "CustomerCollectionViewCell")
        
        NetworkViewModel = NetworkingViewModel()
        let url = "\(NetworkServices.base_url)\(EndPoint.Customers.path)"
        print("url is:\(url)")
        NetworkViewModel.getCutomers(url: url)
        NetworkViewModel.bindingCustomersResult = { () in
            DispatchQueue.main.async {
                self.customerArray = self.NetworkViewModel?.customersResult.customers
                self.customersCollecctionView.reloadData()
            }
        }
    }
    
   

    @IBAction func logoutButton(_ sender: UIButton) {
  // let LVC = storyboard?.instantiateViewController(withIdentifier: "login") as! LoginViewController
  //(UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.setRootViewController(LVC)
  // self.navigationController?.popToRootViewController(animated: true)
    }

}

extension StoreViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return customerArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomerCollectionViewCell", for: indexPath) as! CustomerCollectionViewCell
        cell.nameLabel.text = "\(customerArray?[indexPath.row].first_name ?? "") \(customerArray?[indexPath.row].last_name ?? "")"
        cell.emailLabel.text = customerArray?[indexPath.row].email ?? ""
        cell.totalSpentLabel.text = "\(customerArray?[indexPath.row].total_spent ?? "0")"
        cell.ordersLabel.text = "\(customerArray?[indexPath.row].orders_count ?? 0)"
        cell.layer.cornerRadius = 12
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:collectionView.bounds.width - 20, height: collectionView.bounds.height/3)
    }
    
}
