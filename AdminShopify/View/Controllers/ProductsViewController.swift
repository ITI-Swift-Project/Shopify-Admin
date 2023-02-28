//
//  ProductsViewController.swift
//  AdminShopify
//
//  Created by Ahmad Ayman Mansour on 25/02/2023.
//

import UIKit


class ProductsViewController: UIViewController {

    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var productsSearchBar: UISearchBar!
    
    var NetworkViewModel : NetworkingViewModel!
    var productsArray : Products?
    var displayArray : [Product]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkViewModel = NetworkingViewModel()
        let url = "\(NetworkServices.base_url)\(EndPoint.all.path)"
        print("urlis:\(url)")
        NetworkViewModel.getAllProducts(url: url)
        NetworkViewModel.bindingProductsResult = { () in
            DispatchQueue.main.async {
                self.productsArray = self.NetworkViewModel?.allProductsResult
                self.displayArray = self.productsArray?.products
                self.productsCollectionView.reloadData()
            }
        }
        
        productsSearchBar.layer.cornerRadius = 12
        productsSearchBar.layer.masksToBounds = true
        
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        productsCollectionView.register(ProductsCollectionViewCell.nib(), forCellWithReuseIdentifier: "ProductsCollectionViewCell")
        self.makeCornerRoundForTabBar()
        
        
    }
    
    
    @IBAction func filterSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0 :
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
        cell.productImageView.image = UIImage(systemName: "camera.circle.fill")
    
        return cell
    }
    
}

extension ProductsViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let PVC = storyboard?.instantiateViewController(withIdentifier: "productCRUD") as! ProductCRUDViewController
        self.present(PVC, animated:true, completion:nil)
    }
    
}

extension ProductsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width-10, height: (collectionView.bounds.height/5)-10)
    }
    
}
