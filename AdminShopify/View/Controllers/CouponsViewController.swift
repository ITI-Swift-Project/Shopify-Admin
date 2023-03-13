//
//  CouponsViewController.swift
//  AdminShopify
//
//  Created by Ahmad Ayman Mansour on 25/02/2023.
//

import UIKit

class CouponsViewController: UIViewController {
    

    @IBOutlet weak var couponsSearchBar: UISearchBar! {
        didSet {
            couponsSearchBar.delegate = self
            couponsSearchBar.layer.cornerRadius = 12
            couponsSearchBar.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var couponsTableView : UITableView! {
        didSet {
            couponsTableView.delegate = self
            couponsTableView.dataSource = self
            couponsTableView.register(CouponsTableViewCell.nib(), forCellReuseIdentifier: "CouponsTableViewCell")
        }
    }
    
    var NetworkViewModel : NetworkingViewModel! = NetworkingViewModel()
    var couponsArray : Discounts?
    var displayArray : [Discount]?
    var priceRule : price_rule?
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        couponsTableView.addGestureRecognizer(longPressRecognizer)
        couponsTableView.allowsSelection = false

        couponsTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
      
        
        self.getAllCoupons()
        self.setNavigationItem()
        self.swipeToDismiss()
    }
    
    
    
    
    //MARK: - Interact with the view methods
    @objc func refreshData(){
        getAllCoupons()
        refreshControl.endRefreshing()
    }
    
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
            if gestureRecognizer.state == .began {
                let point = gestureRecognizer.location(in: couponsTableView)
                if let indexPath = couponsTableView.indexPathForRow(at: point) {
                    couponsTableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    couponsTableView?.delegate?.tableView?(couponsTableView, didSelectRowAt: indexPath)
                }
            }
        }
    @IBAction func addCouponButton(_ sender: UIButton) {
        let CVC = storyboard?.instantiateViewController(withIdentifier: "couponCRUD") as! CouponCRUDViewController
        CVC.priceRuleID = priceRule?.id
        self.present(CVC, animated:true, completion:nil)
    }
    
    //MARK: - Set Navigation Bar
    func setNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.backward.fill"), style: .plain, target: self, action:#selector(dismissViewController))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "D9D9D9")
        navigationItem.title = "Coupons off \(priceRule?.value ?? "")%"
    }
    func swipeToDismiss() {
        let swipRight = UISwipeGestureRecognizer(target: self, action: #selector(dismissViewController))
        swipRight.direction = .right
        self.view.addGestureRecognizer(swipRight)
    }
    
    @objc func dismissViewController(){
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Preoeration Price Rules and Coupons
    func getAllCoupons(){
        let couponsUrl = "\(NetworkServices.base_url)\(EndPoint.Coupons(id:priceRule?.id ?? 0).path)"
            print("Coupon url is:\(couponsUrl)")
            self.NetworkViewModel.getCoupons(url: couponsUrl)
            self.NetworkViewModel.bindingCouponsResult = { () in
                DispatchQueue.main.async {
                    self.couponsArray = self.NetworkViewModel?.couponsResult
                    self.displayArray = self.couponsArray?.discount_codes
                    self.couponsTableView.reloadData()
                }
            }
     }
}

     

//MARK: - Coupons TableView View Protocols


extension CouponsViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Delete", message: "Are Sure You Want To Delete?" , preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default , handler: { action  in
                let url = "\(NetworkServices.base_url)/price_rules/\(self.displayArray?[indexPath.row].price_rule_id ?? 0)/discount_codes/\(self.displayArray?[indexPath.row].id ?? 0).json"
                NetworkServices.delete(stringURL: url)
                self.displayArray?.remove(at: indexPath.row)
                self.couponsArray?.discount_codes?.remove(at: indexPath.row)
                self.couponsTableView.reloadData()
            }))
            alert.addAction(UIAlertAction(title: "Cancle", style: UIAlertAction.Style.default ))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alert : UIAlertController = UIAlertController(title: "Update || Delete", message: " Please Select  Which Action You Want To Perform ", preferredStyle: .actionSheet)
        let edit = UIAlertAction(title: "Edit", style: .default , handler: { [self]action in
            let CVC = storyboard?.instantiateViewController(withIdentifier: "couponCRUD") as! CouponCRUDViewController
            CVC.coupon = displayArray?[indexPath.row]
            self.present(CVC, animated:true, completion:nil)
        })
        
        let delete = UIAlertAction(title: "Delete", style: .default , handler: { [self]action in
            let url = "\(NetworkServices.base_url)/price_rules/\(displayArray?[indexPath.row].price_rule_id ?? 0)/discount_codes/\(displayArray?[indexPath.row].id ?? 0).json"
            NetworkServices.delete(stringURL: url)
            displayArray?.remove(at: indexPath.row)
            couponsArray?.discount_codes?.remove(at: indexPath.row)
            couponsTableView.reloadData()
        })
        
        edit.setValue(UIColor.systemYellow , forKey: "titleTextColor")
        delete.setValue(UIColor.red , forKey: "titleTextColor")
        let cancle = UIAlertAction(title: "Cancle", style: .cancel, handler: nil)
        
        alert.addAction(edit)
        alert.addAction(delete)
        alert.addAction(cancle)
        
        self.present(alert, animated: true , completion: nil)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(tableView.bounds.height/7)
    }
    
}

extension CouponsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CouponsTableViewCell", for: indexPath) as! CouponsTableViewCell
        
        cell.couponCodeLabel.text = displayArray?[indexPath.row].code ?? ""
        
        return cell
    }
}

 
//MARK: - Coupons Search Bar
extension CouponsViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        displayArray = []
    
                if searchText == "" {
                    displayArray = couponsArray?.discount_codes
                }
        for coupon in couponsArray?.discount_codes ?? [] {
            if coupon.code.uppercased().contains(searchText.uppercased()){
                displayArray?.append(coupon)
            }
        }
        self.couponsTableView.reloadData()
    }
}
