//
//  LCCNetworkingManager.swift
//  FrameworkTest
//
//  Created by yuanjilee on 2017/8/14.
//  Copyright © 2017年 yuanjilee. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift


/// 做数据库操作
class LCCNetworkingManager {
  
  static let shared = LCCNetworkingManager()
  
  func sendReqest(success: @escaping(_ reslut: JSON) ->(), failure: @escaping(_ result: Error) -> ()) {
    
    let url = "http://www.mocky.io/v2/5992c9091200007c00313bc9" // "https://httpbin.org/get"

    HTTPClient.shared.sendRequest(url: url, method: .get, parameters: nil, success: { (response: JSON) in
      // cache
      
      let person = Person()
      person.personID = "key"
      person.name = response["headers"]["Accept"].stringValue
      person.age = response["origin"].intValue
      person.sex = response["Upgrade-Insecure-Requests"].boolValue
      person.sex = true
      
      let realm = try! Realm()
      try! realm.write {
        realm.add(person, update: true)
      }
      
      success(response)
    }) { (error: Error) in
      failure(error)
    }
  }
  
}
