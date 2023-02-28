//
//  NetworkingViewModel.swift
//  AdminShopify
//
//  Created by Ahmad Ayman Mansour on 27/02/2023.
//

import Foundation


class NetworkingViewModel {
    
    //MARK: - Fetching Products
    var bindingProductsResult : (()->()) = {}
    var bindingMenProductsResult : (()->()) = {}
    var bindingWomenProductsResult : (()->()) = {}
    var bindingKidsProductsResult : (()->()) = {}
    var bindingSaleProductsResult : (()->()) = {}
    
    
    var allProductsResult : Products!{
        didSet{
            bindingProductsResult()
        }
    }
    
    var menProductsResult : Products!{
        didSet{
            bindingMenProductsResult()
        }
    }
    
    var womenProductsResult : Products!{
        didSet{
            bindingWomenProductsResult()
        }
    }
    
    var KidsProductsResult : Products!{
        didSet{
            bindingKidsProductsResult()
        }
    }
    
    var saleProductsResult : Products!{
        didSet{
            bindingSaleProductsResult()
        }
    }
    
    
    
    
    func getAllProducts(url : String){
        NetworkServices.fetch(url: url) { result in
            self.allProductsResult = result
        }
    }
    
    func getMenProducts(url : String){
        NetworkServices.fetch(url: url) { result in
            self.menProductsResult = result
        }
    }
    
    func getWomenProducts(url : String){
        NetworkServices.fetch(url: url) { result in
            self.womenProductsResult = result
        }
        
    }
    func getKidsProducts(url : String){
        NetworkServices.fetch(url: url) { result in
            self.KidsProductsResult = result
        }
        
    }
    func getSaleProducts(url : String){
        NetworkServices.fetch(url: url) { result in
            self.saleProductsResult = result
        }
    }
    
    //MARK: - Fetching Coupons
    var bindingCouponsResult : (()->()) = {}

    var couponsResult : Discounts!{
        didSet{
            bindingCouponsResult()
        }
    }
    
    func getCoupons(url : String){
        NetworkServices.fetch(url: url) { result in
            self.couponsResult = result
        }
    }
    
    
}

