//
//  HTTPClient.swift
//  FrameworkTest
//
//  Created by yuanjilee on 2017/8/14.
//  Copyright © 2017年 yuanjilee. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class HTTPClient {
  static let shared: HTTPClient = HTTPClient()
  
  func sendRequest(url: String, method: HTTPMethod, parameters: Parameters?, success: @escaping(_ reslut: JSON) ->(), failure: @escaping(_ result: Error) -> ()) {
    
    let url = baseUrlFromCurrentTeam() + url
    let headers = getHeaders()
  
    Alamofire.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response: DataResponse<Any>) in
      
      debugPrint("Request: \(String(describing: response.request))")   // original url request
      debugPrint("Response: \(String(describing: response.response))") // http url response
      
      switch response.result {
      case .success(let value):
          let json = JSON(value)
          let code = json["data"]["code"].intValue
          if code != 200 {
            success(json)
          } else {
            let error = HTTPError(code: 2, localizedTitle: nil, localizedDescription: "233")
            debugPrint("Code Error: \(String(describing: error))")
            failure(error)
          }
          break
        
        case .failure(let error):
          failure(error)
          debugPrint("Unknow Error: \(String(describing: error))")
          break
      }
    }
  }
  
}

extension HTTPClient {
  
  func getHeaders() -> HTTPHeaders {
    let headers: HTTPHeaders = [
      "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
      "Accept": "application/json"
    ]
    return headers
  }
  
  func baseUrlFromCurrentTeam() -> String {
    let baseUrl = ""
    return baseUrl
  }
}
