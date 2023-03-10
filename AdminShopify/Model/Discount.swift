//
//  Discount.swift
//  AdminShopify
//
//  Created by Ahmad Ayman Mansour on 28/02/2023.
//

import Foundation

struct Discount : Codable  {
    var  id : Int
    var  price_rule_id : Int
    var  code : String
    var  usage_count : Int
    var  customer_selection : String? // "all",
    var  starts_at : String?  //2023-06-01T00:00:00Z,
    var  ends_at : String? //"2023-06-30T23:59:59Z",
    var  created_at : String? //"2023-03-10T12:00:00Z",
    var  updated_at : String? //"2023-03-10T12:00:00Z",
}

class Discounts : Codable {
    var discount_codes : [Discount]?
}

