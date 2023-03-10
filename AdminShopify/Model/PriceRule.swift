//
//  PriceRule.swift
//  AdminShopify
//
//  Created by Ahmad Ayman Mansour on 28/02/2023.
//

import Foundation

struct price_rule : Codable{
    var  id : Int?
    var  value_type : String?
    var  value : String?
    var  customer_selection : String?
    var  once_per_customer: Bool?
    var  usage_limit : Int?
    var  title : String?
    var  starts_at : String?
    var  ends_at : String?
    var  created_at : String?
    var  updated_at : String?
}

class Prices_Rules : Codable {
    var price_rules : [price_rule]?
}

