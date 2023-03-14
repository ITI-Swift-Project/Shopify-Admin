//
//  PriceRulesViewController.swift
//  AdminShopify
//
//  Created by Ahmad Ayman Mansour on 10/03/2023.
//

import UIKit

class PriceRulesViewController: UIViewController {

    @IBOutlet weak var priceRulesSearchBar: UISearchBar! {
        didSet {
            priceRulesSearchBar.delegate = self
            priceRulesSearchBar.layer.cornerRadius = 12
            priceRulesSearchBar.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var priceRulesCollectionView: UICollectionView! {
        didSet {
            priceRulesCollectionView.delegate = self
            priceRulesCollectionView.dataSource = self
            priceRulesCollectionView.register(PriceRulesCollectionViewCell.nib(), forCellWithReuseIdentifier: "PriceRulesCollectionViewCell")
        }
    }
    
    let refreshControl = UIRefreshControl()
    var priceRuleArray : Prices_Rules?
    var priceRuleDisplayArray : [price_rule]?
    var parameters : [String : Any]?
    
    var NetworkViewModel : NetworkingViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkViewModel = NetworkingViewModel()
        self.getPriceRules()
        
        priceRulesCollectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        priceRulesCollectionView.addGestureRecognizer(longPressRecognizer)
        
    }
    
    
    @objc func refreshData(){
    self.getPriceRules()
    refreshControl.endRefreshing()
    }
    
    
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let point = gestureRecognizer.location(in: priceRulesCollectionView)
            if let indexPath = priceRulesCollectionView.indexPathForItem(at: point) {
                priceRulesCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredVertically)
                let alert : UIAlertController = UIAlertController(title: "Update || Delete", message: " Please Select  Which Action You Want To Perform ", preferredStyle: .actionSheet)
                let edit = UIAlertAction(title: "Edit", style: .default , handler: { [self]action in
                    let PRCVC = storyboard?.instantiateViewController(withIdentifier: "priceRulesCRUD") as! PriceRulesCRUDViewController
                    PRCVC.priceRule = priceRuleDisplayArray?[indexPath.row]
                    self.present(PRCVC, animated:true, completion:nil)
                })
                
                let delete = UIAlertAction(title: "Delete", style: .default , handler: { [self]action in
                    let alert = UIAlertController(title: "Delete", message: "Are Sure You Want To Delete?" , preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default , handler: { action  in
                        let url = EndPoint.price_rule(id: self.priceRuleDisplayArray?[indexPath.row].id ?? 0).path
                        NetworkServices.delete(stringURL: url)
                        self.priceRuleDisplayArray?.remove(at: indexPath.row)
                        self.priceRuleArray?.price_rules?.remove(at: indexPath.row)
                        self.priceRulesCollectionView.reloadData()
                    }))
                    alert.addAction(UIAlertAction(title: "Cancle", style: UIAlertAction.Style.default ))
                    self.present(alert, animated: true, completion: nil)
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
    }

    @IBAction func addPriceRuleButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Add Price Rule", message: "", preferredStyle: .alert)
        alert.addTextField{ (textField) in
            textField.placeholder = "Title"
        }
        alert.addTextField{ (textField) in
            textField.placeholder = "value (1 - 100)"
        }
       
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
            if alert.textFields?[0].text != "" && alert.textFields?[1].text != "" {
                self.parameters = [
                    "price_rule": [
                        "title": "\(alert.textFields?[0].text ?? "0")",
                        "target_type": "line_item",
                        "target_selection": "all",
                        "allocation_method": "across",
                        "value_type": "percentage",
                        "value": "-\(alert.textFields?[1].text ?? "1")",
                        "customer_selection": "all",
                        "starts_at": "2023-03-10T12:00:00-04:00",
                        "ends_at": "2023-03-28T12:00:00-04:00"
                    ]
                ]
                let url = "\(NetworkServices.base_url)price_rules.json"
                NetworkServices.post(parameters: self.parameters ?? [:], stringUrl: url)
            }else{
                print("Invalid Data")
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func getPriceRules() {
        let priceRuleUrl = "\(NetworkServices.base_url)\(EndPoint.Price_rules.path)"
        print("Price Rule url is:\(priceRuleUrl)")
        self.NetworkViewModel.getPriceRules(url: priceRuleUrl)
        self.NetworkViewModel.bindingPriceRulesResult = { () in
            DispatchQueue.main.async {
                self.priceRuleArray = self.NetworkViewModel?.priceRulesResult
                self.priceRuleDisplayArray = self.priceRuleArray?.price_rules
                self.priceRulesCollectionView.reloadData()
            }
        }
    }
  

}



//MARK: - price CollectionView Protocols

extension PriceRulesViewController :  UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return priceRuleDisplayArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PriceRulesCollectionViewCell", for: indexPath) as! PriceRulesCollectionViewCell
        cell.priceRuleTitleLabel.text = priceRuleDisplayArray?[indexPath.row].title ?? ""
        cell.priceRuleValueLabel.text = "\(priceRuleDisplayArray?[indexPath.row].value ?? "") %"
        cell.layer.cornerRadius = 12
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    
}
  
extension PriceRulesViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let CVC = storyboard?.instantiateViewController(withIdentifier: "coupons") as! CouponsViewController
        CVC.priceRule = priceRuleDisplayArray?[indexPath.row]
        let NC = UINavigationController(rootViewController: CVC)
        NC.modalPresentationStyle = .fullScreen
        self.present(NC, animated:true, completion:nil)
    }
}

extension PriceRulesViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.width - 40)*0.5, height: self.view.frame.height * 0.18)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0 , left: 10, bottom: 0, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(15)
    }
    
}



//MARK: - Price Rules Search Bar
extension PriceRulesViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        priceRuleDisplayArray = []
                if searchText == "" {
                    priceRuleDisplayArray = priceRuleArray?.price_rules
                }
        for priceRule in priceRuleArray?.price_rules ?? [] {
            if priceRule.title!.uppercased().contains(searchText.uppercased()){
                priceRuleDisplayArray?.append(priceRule)
            }
        }
        self.priceRulesCollectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        priceRulesSearchBar.endEditing(true)
    }
}

