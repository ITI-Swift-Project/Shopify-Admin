

import Foundation

protocol CRUDProtocol {
    
    static func post  (parameters : [String : Any] , stringUrl: String)
    static func edit (parameters : [String : Any] , stringUrl: String)
    static func delete (stringURL : String)
    
}


