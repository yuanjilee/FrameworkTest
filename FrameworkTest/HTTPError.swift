//
//  HTTPError.swift
//  FrameworkTest
//
//  Created by yuanjilee on 2017/8/15.
//  Copyright © 2017年 yuanjilee. All rights reserved.
//


protocol ErrorProtocol: Error {
  
  var localizedTitle: String { get }
  var localizedDescription: String { get }
  var code: Int { get }
}


class HTTPError: ErrorProtocol {
  
  var code: Int
  var localizedTitle: String
  var localizedDescription: String
  
  init(code: Int, localizedTitle: String?, localizedDescription: String) {
    self.code = code
    self.localizedTitle = localizedTitle ?? "Error"
    self.localizedDescription = localizedDescription
  }
}
