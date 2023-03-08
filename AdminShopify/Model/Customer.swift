//
//  Customer.swift
//  AdminShopify
//
//  Created by Ahmad Ayman Mansour on 28/02/2023.
//

import Foundation

struct Customer : Codable{
   var first_name :  String?
   var last_name : String?
   var orders_count : Int?
   var total_spent : String?
   var currency : String?
   var email : String?
}

class Customers : Codable {
    var customers : [Customer]?
}
