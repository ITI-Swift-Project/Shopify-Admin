//
//  Products.swift
//  AdminShopify
//
//  Created by Ahmad Ayman Mansour on 28/02/2023.
//

import Foundation

struct Image : Codable {
    var id: Int?
    var src : String?
    var product_id: Int?
    var position: Int?
}

struct Variants : Codable{
    var id: Int?
    var title: String?
    var sku: String?
    var price : String?
    var product_id: Int?
    var position: Int?
    var fulfillment_service: String?
    var option1: String?
    var option2: String?
    var option3: String?
    var taxable: Bool?
    var inventory_item_id: Int?
    var inventory_quantity : Int?
}

class Option: Codable {
    var id: Int
    var product_id: Int
    var name: String
    var position: Int?
    var values: [String]?
}


struct Product : Codable {
    var id : Int?
    var title : String?
    var vendor : String?
    var body_html : String?
    var image : Image?
    var images: [Image]?
    var variants : [Variants]?
    var product_type: String?
    var handle: String
    var status: String
    var options: [Option]?
    
}

class Products : Codable {
    var products : [Product]?
}
