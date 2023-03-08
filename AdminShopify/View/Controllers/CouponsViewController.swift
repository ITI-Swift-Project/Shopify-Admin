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
    
    
    var displayPriceRule : price_rule?
    var NetworkViewModel : NetworkingViewModel! = NetworkingViewModel()
    var couponsArray : Discounts?
    var allCouponsArray : [Discount]? = []
    var allCouponsArrayDisplay : [Discount]? = []
    var displayArray : [Discount]?
    var priceRuleArray : Prices_Rules?
    var priceRuleDisplayArray : [price_rule]?
    var priceRulesIds : [Int] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getPriceRulesAndCouponsData()

        couponsCollectionView.delegate = self
        couponsCollectionView.dataSource = self
        couponsCollectionView.register(CouponsCollectionViewCell.nib(), forCellWithReuseIdentifier: "CouponsCollectionViewCell")
        
        couponsSearchBar.delegate = self
        couponsSearchBar.layer.cornerRadius = 12
        couponsSearchBar.layer.masksToBounds = true
    }
    
    
    @IBAction func addCouponButton(_ sender: UIButton) {
        let CVC = storyboard?.instantiateViewController(withIdentifier: "couponCRUD") as! CouponCRUDViewController
        CVC.priceRules = priceRuleDisplayArray
        self.present(CVC, animated:true, completion:nil)
    }
    
    
    
    
    //MARK: - Preoeration Price Rules and Coupons
    func getPriceRulesAndCouponsData() {
        let priceRuleUrl = "\(NetworkServices.base_url)\(EndPoint.Price_rules.path)"
        print("Price Rule url is:\(priceRuleUrl)")
        self.NetworkViewModel.getPriceRules(url: priceRuleUrl)
        self.NetworkViewModel.bindingPriceRulesResult = { () in
            OperationQueue.main.addOperation {
                self.priceRuleArray = self.NetworkViewModel?.priceRulesResult
                self.priceRuleDisplayArray = self.priceRuleArray?.price_rules
                for pr in self.priceRuleDisplayArray ?? []{
                    self.priceRulesIds.append(pr.id ?? 0)
                }
                self.getAllCoupons()
            }
        }
    }
    
    func getAllCoupons(){
        for id in priceRulesIds {
            let couponsUrl = "\(NetworkServices.base_url)\(EndPoint.Coupons(id:id).path)"
            print("Coupon url is:\(couponsUrl)")
            self.NetworkViewModel.getCoupons(url: couponsUrl)
            self.NetworkViewModel.bindingCouponsResult = { () in
                OperationQueue.main.addOperation {
                    self.couponsArray = self.NetworkViewModel?.couponsResult
                    self.displayArray = self.couponsArray?.discount_codes
                    for coupon in self.displayArray ?? [] {
                        self.allCouponsArray?.append(coupon)
                        print("from coupons : \(self.allCouponsArray?.count ?? 0) .. \(coupon)")
                    }
                    self.allCouponsArrayDisplay = self.allCouponsArray
                    self.couponsCollectionView.reloadData()
                }
            }
        }
    }

}



//MARK: - Coupons Collection View Protocols

extension CouponsViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allCouponsArrayDisplay?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CouponsCollectionViewCell", for: indexPath) as! CouponsCollectionViewCell
       
        let pr_id = allCouponsArrayDisplay?[indexPath.row].price_rule_id
        for pr in priceRuleArray?.price_rules ?? [] {
            if pr.id == pr_id {
            displayPriceRule = pr
            }
        }
        cell.discountNameLabel.text = displayPriceRule?.title
        cell.discountValueLabel.text = "\(displayPriceRule?.value ?? "")%"
        cell.discountImageView.image = UIImage(named: "frame1")
        cell.discountCodeLabel.text = allCouponsArrayDisplay?[indexPath.row].code
        cell.discountCodeLabel.adjustsFontSizeToFitWidth = true
        cell.layer.cornerRadius = 17
        cell.layer.masksToBounds = true
      
        
        return cell
    }
    
    
}

extension CouponsViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alert : UIAlertController = UIAlertController(title: "Update || Delete", message: " Please Select  Which Action You Want To Perform ", preferredStyle: .actionSheet)
        let edit = UIAlertAction(title: "Edit", style: .default , handler: { [self]action in
            let CVC = storyboard?.instantiateViewController(withIdentifier: "couponCRUD") as! CouponCRUDViewController
            CVC.coupon = allCouponsArrayDisplay?[indexPath.row]
            CVC.priceRules = priceRuleDisplayArray
            self.present(CVC, animated:true, completion:nil)
        })
        
        let delete = UIAlertAction(title: "Delete", style: .default , handler: { [self]action in
            //price_rules/507328175/discount_codes/507328175.json
            //price_rules/507328175/discount_codes/507328175.json
            let url = "\(NetworkServices.base_url)/price_rules/\(allCouponsArrayDisplay?[indexPath.row].price_rule_id ?? 0)/discount_codes/\(allCouponsArrayDisplay?[indexPath.row].id ?? 0).json"
            NetworkServices.delete(stringURL: url)
            allCouponsArrayDisplay?.remove(at: indexPath.row)
            couponsCollectionView.reloadData()
        })
        
        edit.setValue(UIColor.systemYellow , forKey: "titleTextColor")
        delete.setValue(UIColor.red , forKey: "titleTextColor")
        let cancle = UIAlertAction(title: "Cancle", style: .cancel, handler: nil)
        
        alert.addAction(edit)
        alert.addAction(delete)
        alert.addAction(cancle)
        self.present(alert, animated: true , completion: nil)
        
    }
    
}

extension CouponsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width-10, height: (collectionView.bounds.height/6)-10)
    }
}
 
//MARK: - Coupons Search Bar
extension CouponsViewController : UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//        displayArray = []
//
//        if searchText == "" {
//            displayArray = couponsArray?.products
//        }
//        for product in  (couponsArray?.products)! {
//            if product.title!.uppercased().contains(searchText.uppercased()){
//                displayArray?.append(product)
//            }
//        }
//        self.productsCollectionView.reloadData()
//    }
}
