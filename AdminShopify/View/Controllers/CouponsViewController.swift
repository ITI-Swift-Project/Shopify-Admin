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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        couponsSearchBar.layer.cornerRadius = 12
        couponsSearchBar.layer.masksToBounds = true
        
        couponsCollectionView.delegate = self
        couponsCollectionView.dataSource = self
        couponsCollectionView.register(CouponsCollectionViewCell.nib(), forCellWithReuseIdentifier: "CouponsCollectionViewCell")
    }
    
    @IBAction func addCouponButton(_ sender: UIButton) {
        let CVC = storyboard?.instantiateViewController(withIdentifier: "couponCRUD") as! CouponCRUDViewController
        self.present(CVC, animated:true, completion:nil)
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

extension CouponsViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CouponsCollectionViewCell", for: indexPath) as! CouponsCollectionViewCell
        
        cell.discountImageView.image = UIImage(systemName: "percent")
        cell.layer.cornerRadius = 17
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    
}

extension CouponsViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let CVC = storyboard?.instantiateViewController(withIdentifier: "couponCRUD") as! CouponCRUDViewController
        self.present(CVC, animated:true, completion:nil)
    }
    
}

extension CouponsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width-10, height: (collectionView.bounds.height/5)-10)
    }
}
 
