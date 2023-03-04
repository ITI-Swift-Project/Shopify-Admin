//
//  Products.swift
//  AdminShopify
//
//  Created by Ahmad Ayman Mansour on 28/02/2023.
//

import Foundation

struct image : Codable {
    var src : String?
}

struct variants : Codable{
    var price : String?
    var inventory_quantity : Int?
}


struct Product : Codable {
    var id : Int?
    var title : String?
    var vendor : String?
    var body_html : String?
    var image : image?
    var variants : [variants]?
}

class Products : Codable {
    var products : [Product]?
}




