//
//  EndPoints.swift
//  AdminShopify
//
//  Created by Ahmad Ayman Mansour on 27/02/2023.
//

import Foundation

enum EndPoint {
    
    case all
    case Men
    case Women
    case Kids
    case Sale
    case Coupons (id: Int)
    case Customers
    
    var path: String {
        switch self {
        case .all:  return "products.json"
        case .Men:  return "products.json?collection_id=437626929456"
        case .Women: return "products.json?collection_id=437626962224"
        case .Kids:  return "products.json?collection_id=437626994992"
        case .Sale:  return "products.json?collection_id=437627027760"
        case .Coupons (id: let id): return "price_rules/\(id)/discount_codes.json"
        case .Customers: return "customers.json"
        }
    }
    
}
