//
//  Services.swift
//  Shopify
//
//  Created by Jitendra Rajput on 04/12/20.
//

import Foundation

enum MethodType:String {
    case GET = "GET"
    case POST = "POST"
}

class Services{
    private init(){}
    static var shared = Services()
    
    func requestData(method: MethodType = .GET,url: String,_ params: Any?=nil,completion: @escaping(_ data: Data?,_ error: String?)-> Void){
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = method.rawValue
        request.timeoutInterval = 30
        if method == MethodType.POST{
            var postBody: Data!
            do{
                postBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            }catch{
                postBody = nil
                completion(nil,"Invalid Json Body")
                return
            }
            request.httpBody = postBody
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { (data,response,error) in
            let resp = response as! HTTPURLResponse
            switch(resp.statusCode){
            case 200...299:
                completion(data,nil)
                break
            default:
                completion(nil,error?.localizedDescription)
                break
            }
        })
        task.resume()
    }
}
