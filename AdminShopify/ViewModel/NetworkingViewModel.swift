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
    
    //MARK: - Fetching Price Rules & Coupons
    var bindingCouponsResult : (()->()) = {}
    var bindingPriceRulesResult : (()->()) = {}

    var couponsResult : Discounts!{
        didSet{
            bindingCouponsResult()
        }
    }
    var priceRulesResult : Prices_Rules!{
        didSet{
            bindingPriceRulesResult()
        }
    }
    
    func getCoupons(url : String){
        NetworkServices.fetch(url: url) { result in
            self.couponsResult = result
        }
    }
    func getPriceRules(url : String){
        NetworkServices.fetch(url: url) { result in
            self.priceRulesResult = result
        }
    }
    
    
    //MARK: - Fetching Customers
    var bindingCustomersResult : (()->()) = {}

    var customersResult : Customers!{
        didSet{
            bindingCustomersResult()
        }
    }
    
    func getCutomers(url : String){
        NetworkServices.fetch(url: url) { result in
            self.customersResult = result
        }
    }
    
    //MARK: - Post
    var bindingPostResponse : (()->()) = {}

    var postResponse :[String:Any]!{
        didSet{
            bindingPostResponse()
        }
    }
//    func post (url : String, paremeters : [String : Any] ){
//        NetworkServices.postMethod(url: url, parameters: paremeters) { response in
//            self.postResponse = response
//        }
//    }
    
    var bindingPostResponse2 : (()->()) = {}
    
    var postResponse2 :Result<Data, Error>!{
        didSet{
            bindingPostResponse2()
        }
    }
    
    func post (url : String,  paremeters : [String : Any],completionHandler :  @escaping (Result<Data, Error>) -> Void)
    {
        NetworkServices.post(url: url, parameters: paremeters, completionHandler: completionHandler)
    }
    
}

