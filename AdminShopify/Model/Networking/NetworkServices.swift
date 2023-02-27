//
//  NetworkServices.swift
//  AdminShopify
//
//  Created by Ahmad Ayman Mansour on 27/02/2023.
//

import Foundation
import Alamofire



//protocol Services {
//    static func fetch<T : Decodable>(url:String?,compiletionHandler : @escaping (T?)->Void)
//}

class NetworkServices {
    static let base_url = "48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023/admin/api/2023-01/"
    static func fetch<T:Decodable> (url:String? , compiletionHandler:@escaping (T?)->Void ){
          AF.request(url ?? "" )
            .validate()
            .responseDecodable (of: T.self ){ data in
                guard let data = data.value else {return}
                compiletionHandler(data)
            }
    }
}
