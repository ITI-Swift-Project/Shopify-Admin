//
//  Discount.swift
//  AdminShopify
//
//  Created by Ahmad Ayman Mansour on 28/02/2023.
//

import Foundation

struct Discount : Codable {
  var  id : Int
  var  price_rule_id : Int
  var  code : String
  var  usage_count : Int
}

class Discounts : Codable{
    var discount_codes : [Discount]?
}

