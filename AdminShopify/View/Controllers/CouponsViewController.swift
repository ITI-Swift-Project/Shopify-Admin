//
//  CouponsViewController.swift
//  AdminShopify
//
//  Created by Ahmad Ayman Mansour on 25/02/2023.
//

import UIKit

class CouponsViewController: UIViewController {

    @IBOutlet weak var couponsSearchBar: UISearchBar!
    @IBOutlet weak var couponsCollectionView: UICollectionView!
    
    var NetworkViewModel : NetworkingViewModel!
    var couponsArray : Discounts?
    var displayArray : [Discount]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkViewModel = NetworkingViewModel()
        let url = "\(NetworkServices.base_url)\(EndPoint.Coupons(id:1382520553776).path)"
        print("url is:\(url)")
        NetworkViewModel.getCoupons(url: url)
        NetworkViewModel.bindingCouponsResult = { () in
            DispatchQueue.main.async {
                self.couponsArray = self.NetworkViewModel?.couponsResult
                self.displayArray = self.couponsArray?.discount_codes
                self.couponsCollectionView.reloadData()
            }
        }

        
        
        
        
        couponsCollectionView.delegate = self
        couponsCollectionView.dataSource = self
        couponsCollectionView.register(CouponsCollectionViewCell.nib(), forCellWithReuseIdentifier: "CouponsCollectionViewCell")
        couponsSearchBar.layer.cornerRadius = 12
        couponsSearchBar.layer.masksToBounds = true
    }
    
    
    @IBAction func addCouponButton(_ sender: UIButton) {
        let CVC = storyboard?.instantiateViewController(withIdentifier: "couponCRUD") as! CouponCRUDViewController
        self.present(CVC, animated:true, completion:nil)
    }
    
  

}



//MARK: - Coupons Collection View Protocols

extension CouponsViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CouponsCollectionViewCell", for: indexPath) as! CouponsCollectionViewCell
        
        cell.discountImageView.image = UIImage(named: "30")
        cell.discountCodeLabel.text = displayArray?[indexPath.row].code
        cell.discountCodeLabel.adjustsFontSizeToFitWidth = true
        cell.layer.cornerRadius = 17
        cell.layer.masksToBounds = true
        
        
        return cell
    }
    
    
}

extension CouponsViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let CVC = storyboard?.instantiateViewController(withIdentifier: "couponCRUD") as! CouponCRUDViewController
        CVC.coupon = displayArray?[indexPath.row]
        self.present(CVC, animated:true, completion:nil)
    }
    
}

extension CouponsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width-10, height: (collectionView.bounds.height/6)-10)
    }
}
 
