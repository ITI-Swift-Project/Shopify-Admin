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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productsSearchBar.layer.cornerRadius = 12
        productsSearchBar.layer.masksToBounds = true
        
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        productsCollectionView.register(ProductsCollectionViewCell.nib(), forCellWithReuseIdentifier: "ProductsCollectionViewCell")
        self.makeCornerRoundForTabBar()
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

extension ProductsViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCollectionViewCell", for: indexPath) as! ProductsCollectionViewCell
        cell.layer.cornerRadius = 12
        cell.layer.masksToBounds = true
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
