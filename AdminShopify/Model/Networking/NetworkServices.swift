import Foundation
import Alamofire



class NetworkServices {
    static let base_url = "https://48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023.myshopify.com/admin/api/2023-01/"
    static func fetch<T:Decodable> (url:String? , compiletionHandler:@escaping (T?)->Void ){
        AF.request(url ?? "" )
            .validate()
            .responseDecodable (of: T.self ){ data in
                guard let data = data.value else {return}
                compiletionHandler(data)
            }
    }
}



//MARK: - Geniric CRUD Methods 
extension NetworkServices : CRUDProtocol {
    
    static func post(parameters: [String : Any], stringUrl: String) {
        guard let url = URL(string: stringUrl ) else {return}
        print(url)
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.httpShouldHandleCookies = false
        let session = URLSession.shared

        do {
            
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters , options: .prettyPrinted)
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: request) {(data, response, error)in
            if error != nil {
                print(error!)
            } else {
                if let data = data {
                    print (data)
                    print(response!)
                }
            }
        }.resume()
        
    }
    
    static func edit(parameters: [String : Any], stringUrl: String) {
        guard let url = URL(string: stringUrl) else {return}
        print(url)
        var request = URLRequest(url:url)
        request.httpMethod = "PUT"
        request.httpShouldHandleCookies = false
        let session = URLSession.shared

        do {
            
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters , options: .prettyPrinted)
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: request) {(data, response, error)in
            if error != nil {
                print(error!)
            } else {
                if let data = data {
                    print (data)
                    print(response!)
                }
            }
        }.resume()
    }
    
    static func delete(stringURL: String) {
        guard let url = URL(string: stringURL ) else {return}
        print(url)
        var request = URLRequest(url:url)
        request.httpMethod = "DELETE"
        request.httpShouldHandleCookies = false
        let session = URLSession.shared

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: request) {(data, response, error)in
            if error != nil {
                print(error!)
            }
        }.resume()
    }
    
}
 
