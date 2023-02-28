//
//  Products.swift
//  AdminShopify
//
//  Created by Ahmad Ayman Mansour on 28/02/2023.
//

import Foundation

struct image : Decodable {
    var src : String
}

struct Product : Decodable {
    var id : Int
    var title : String
    var vendor : String
    var body_html : String
    var image : image
}

class Products : Decodable {
    var products : [Product]?
}
