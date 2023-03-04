//
//  PriceRule.swift
//  AdminShopify
//
//  Created by Ahmad Ayman Mansour on 28/02/2023.
//

import Foundation

struct price_rule : Codable{
    
  var  value_type : String?  //"percentage",
  var   value : String? //"-30.0"
  var  customer_selection : String? //"all"
  var  once_per_customer: Bool?
  var  usage_limit : Int?
    
}

class Prices_Rules : Codable {
    var price_rules : [price_rule]?
}
