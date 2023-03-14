//
//  ProductsViewController.swift
//  AdminShopify
//
//  Created by Ahmad Ayman Mansour on 25/02/2023.
//

import UIKit
import Kingfisher



class ProductsViewController: UIViewController {
    
    @IBOutlet weak var productsCollectionView: UICollectionView!{
        didSet{
            productsCollectionView.delegate = self
            productsCollectionView.dataSource = self
            productsCollectionView.register(ProductsCollectionViewCell.nib(), forCellWithReuseIdentifier: "ProductsCollectionViewCell")
        }
    }
    @IBOutlet weak var productsSearchBar: UISearchBar! {
        didSet{
            productsSearchBar.delegate = self
            productsSearchBar.layer.cornerRadius = 12
            productsSearchBar.layer.masksToBounds = true
        }
    }
    
   
    var NetworkViewModel : NetworkingViewModel!
    var productsArray : Products?
    var displayArray : [Product]?
    let refreshControl = UIRefreshControl()
    var target : Int?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productsCollectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        productsCollectionView.addGestureRecognizer(longPressRecognizer)
        productsCollectionView.allowsSelection = false
        
        NetworkViewModel = NetworkingViewModel()
        let url = "\(NetworkServices.base_url)\(EndPoint.all.path)"
        print("url is:\(url)")
        NetworkViewModel.getAllProducts(url: url)
        NetworkViewModel.bindingProductsResult = { () in
            DispatchQueue.main.async {
                self.productsArray = self.NetworkViewModel?.allProductsResult
                self.displayArray = self.productsArray?.products
                self.productsCollectionView.reloadData()
            }
        }
        
     
        
        
        self.makeCornerRoundForTabBar()
        
    }
    
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
            if gestureRecognizer.state == .began {
                let point = gestureRecognizer.location(in: productsCollectionView)
                if let indexPath = productsCollectionView.indexPathForItem(at: point) {
                    productsCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredVertically)
                    productsCollectionView?.delegate?.collectionView?(productsCollectionView, didSelectItemAt: indexPath)
                }
            }
        }
    
   
    
    @objc func refreshData(){
        var url = "\(NetworkServices.base_url)\(EndPoint.all.path)"
        switch target {
        case 0 :
            url = "\(NetworkServices.base_url)\(EndPoint.all.path)"
        case 1 :
             url = "\(NetworkServices.base_url)\(EndPoint.Men.path)"
        case 2 :
           url = "\(NetworkServices.base_url)\(EndPoint.Women.path)"
        case 3 :
             url = "\(NetworkServices.base_url)\(EndPoint.Kids.path)"
        case 4 :
             url = "\(NetworkServices.base_url)\(EndPoint.Sale.path)"
        default:
            break
        }
        NetworkViewModel = NetworkingViewModel()
        print("url is:\(url)")
        NetworkViewModel.getAllProducts(url: url)
        NetworkViewModel.bindingProductsResult = { () in
            DispatchQueue.main.async {
                self.productsArray = self.NetworkViewModel?.allProductsResult
                self.displayArray = self.productsArray?.products
                self.productsCollectionView.reloadData()
            }
        }
        refreshControl.endRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NetworkViewModel = NetworkingViewModel()
        let url = "\(NetworkServices.base_url)\(EndPoint.all.path)"
        print("url is:\(url)")
        NetworkViewModel.getAllProducts(url: url)
        NetworkViewModel.bindingProductsResult = { () in
            DispatchQueue.main.async {
                self.productsArray = self.NetworkViewModel?.allProductsResult
                self.displayArray = self.productsArray?.products
                self.productsCollectionView.reloadData()
            }
        }
    }
    
    @IBAction func filterSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0 :
            target = 0
            print("all")
            let url = "\(NetworkServices.base_url)\(EndPoint.all.path)"
            NetworkViewModel.getAllProducts(url: url)
            NetworkViewModel.bindingProductsResult = { () in
                DispatchQueue.main.async {
                    self.productsArray = self.NetworkViewModel?.allProductsResult
                    self.displayArray = self.productsArray?.products
                    self.productsCollectionView.reloadData()
                }
            }
        case 1 :
            target = 1
            print("men")
            let url = "\(NetworkServices.base_url)\(EndPoint.Men.path)"
            NetworkViewModel.getMenProducts(url: url)
            NetworkViewModel.bindingMenProductsResult = { () in
                DispatchQueue.main.async {
                    self.productsArray = self.NetworkViewModel?.menProductsResult
                    self.displayArray = self.productsArray?.products
                    self.productsCollectionView.reloadData()
                }
            }
        case 2 :
            target = 2
            print("women")
            let url = "\(NetworkServices.base_url)\(EndPoint.Women.path)"
            NetworkViewModel.getWomenProducts(url: url)
            NetworkViewModel.bindingWomenProductsResult = { () in
                DispatchQueue.main.async {
                    self.productsArray = self.NetworkViewModel?.womenProductsResult
                    self.displayArray = self.productsArray?.products
                    self.productsCollectionView.reloadData()
                }
            }
        case 3 :
            target = 3
            print("kids")
            let url = "\(NetworkServices.base_url)\(EndPoint.Kids.path)"
            NetworkViewModel.getKidsProducts(url: url)
            NetworkViewModel.bindingKidsProductsResult = { () in
                DispatchQueue.main.async {
                    self.productsArray = self.NetworkViewModel?.KidsProductsResult
                    self.displayArray = self.productsArray?.products
                    self.productsCollectionView.reloadData()
                }
            }
        case 4 :
            target = 4
            print("sale")
            let url = "\(NetworkServices.base_url)\(EndPoint.Sale.path)"
            NetworkViewModel.getSaleProducts(url: url)
            NetworkViewModel.bindingSaleProductsResult = { () in
                DispatchQueue.main.async {
                    self.productsArray = self.NetworkViewModel?.saleProductsResult
                    self.displayArray = self.productsArray?.products
                    self.productsCollectionView.reloadData()
                }
            }
        default:
            break
        }
    }
    
    @IBAction func adProductButton(_ sender: UIButton) {
        let PVC = storyboard?.instantiateViewController(withIdentifier: "productCRUD") as! ProductCRUDViewController
        self.present(PVC, animated:true, completion:nil)
    }
    
    func makeCornerRoundForTabBar(){
        tabBarController?.tabBar.layer.masksToBounds = true
        tabBarController?.tabBar.backgroundColor = UIColor(named: "04395E")
        tabBarController?.tabBar.layer.cornerRadius = UIScreen.main.bounds.width / 20
    }
    
}

//MARK:  Collection View Protocols
extension ProductsViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCollectionViewCell", for: indexPath) as! ProductsCollectionViewCell
        
        cell.layer.cornerRadius = 12
        cell.layer.masksToBounds = true
        
        cell.productNameLabel.text = displayArray?[indexPath.row].title
        cell.productImageView.kf.indicatorType = .activity
        cell.productInventoryLabel.text = String(displayArray?[indexPath.row].variants?[0].inventory_quantity ?? 0);        cell.productImageView.kf.setImage(with: URL(string:displayArray?[indexPath.row].image?.src  ?? "" ),placeholder: UIImage(systemName:"exclamationmark.circle.fill"))
        cell.productVendorLabel.text = displayArray?[indexPath.row].vendor
        cell.productPriceLabel.text = "\((displayArray?[indexPath.row].variants?[0].price) ?? "")$"
        cell.productPriceLabel.adjustsFontSizeToFitWidth = true
        
        
        return cell
    }
    
}

extension ProductsViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alert : UIAlertController = UIAlertController(title: "Update || Delete", message: " Please Select  Which Action You Want To Perform ", preferredStyle: .actionSheet)
        let edit = UIAlertAction(title: "Edit", style: .default , handler: { [self]action in
            let PVC = storyboard?.instantiateViewController(withIdentifier: "productCRUD") as! ProductCRUDViewController
            PVC.product = displayArray?[indexPath.row]
            self.present(PVC, animated:true, completion:nil)
        })
        
        let delete = UIAlertAction(title: "Delete", style: .default , handler: { [self]action in
            
            let alert = UIAlertController(title: "Delete", message: "Are Sure You Want To Delete?" , preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default , handler: { action  in
                let url = "\(NetworkServices.base_url)/products/\(self.displayArray?[indexPath.row].id ?? 0).json"
                NetworkServices.delete(stringURL: url)
                self.displayArray?.remove(at: indexPath.row)
                self.productsCollectionView.reloadData()
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

extension ProductsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 20, height: self.view.frame.height * 0.18)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0 , left: 10, bottom: 0, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(15)
    }
}

//MARK: - Product Search Bar
extension ProductsViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        displayArray = []
        
        if searchText == "" {
            displayArray = productsArray?.products
        }
        for product in  (productsArray?.products)! {
            if product.title!.uppercased().contains(searchText.uppercased()){
                displayArray?.append(product)
            }
        }
        self.productsCollectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        productsSearchBar.endEditing(true)
    }
    
}
