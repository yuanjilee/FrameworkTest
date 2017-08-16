//
//  Person.swift
//  FrameworkTest
//
//  Created by yuanjilee on 2017/8/16.
//  Copyright © 2017年 yuanjilee. All rights reserved.
//

import RealmSwift

class Person: Object {
  
  dynamic var personID: String = ""
  public dynamic var name: String = ""
  dynamic var age: Int = 0
  dynamic var sex: Bool = false
  
  override static func primaryKey() -> String? {
    return "personID"
  }
}
