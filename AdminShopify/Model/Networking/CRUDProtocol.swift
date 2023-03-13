

import Foundation

protocol CRUDProtocol {
    static func post  (parameters : [String : Any] , stringUrl: String)
    static func edit (parameters : [String : Any] , stringUrl: String)
    static func delete(stringURL : String)
}


protocol CRUDProtocol2{
    static func post( url: String ,parameters: [String : Any], completionHandler :  @escaping (Result<Data, Error>) -> Void)
    static func put( url: String ,parameters: [String : Any], completionHandler :  @escaping (Result<Data, Error>) -> Void)
}
