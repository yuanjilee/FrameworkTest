//
//  ViewController.swift
//  FrameworkTest
//
//  Created by yuanjilee on 2017/8/10.
//  Copyright © 2017年 yuanjilee. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class ViewController: UIViewController {
  
  @IBOutlet weak var _textView: UITextView!
  var person: Person?
  lazy var realm: Realm = {
    return try! Realm()
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let path = realm.configuration.fileURL?.absoluteString
    debugPrint(path ?? String())
    
    fetch()
    get()
    modify()
    add()
    delete()
  }
}

extension ViewController {
  
  func fetch() {
//     person = realm.object(ofType: Person.self, forPrimaryKey: "key")

//    guard let per = person else { return }
//    let text = per.personID + " + " + per.name + " + " + String(per.age)
//    _textView.text = text
    
    let persons = realm.objects(Person.self)
    var string = ""
    for person in persons {
      string.append(person.personID + " + " + person.name + " + " + String(person.age))
    }
    _textView.text = string
  }
  
  func get() {
    LCCNetworkingManager.shared.sendReqest(success: { (response: JSON) in
      self._textView.text = "\(response)"
    }) { (error: Error) in
      //
    }
  }
  
  func modify() {
    guard let person = person else { return }
    
    try! realm.write { // All add/modify/delete attempting must be inside of a write transaction
      person.age = 100
      realm.add(person, update: true)
    }
    
  }
  
  func delete() {
    let person = realm.object(ofType: Person.self, forPrimaryKey: "key")
    
    guard let per = person else { return }
    try! realm.write {
      realm.delete(per)
    }
  }
  
  func add() {
    //guard let person = person else { return }
    
    let person = Person()
    person.personID = "key2"
    person.name = "yuanjilee"
    person.age = 101
    person.sex = false
    
    try! realm.write {
      realm.add(person, update: true)
    }
  }
  
//  func get() {
//    Alamofire.request("https://httpbin.org/get").responseJSON { response in
//      print("Request: \(String(describing: response.request))")   // original url request
//      print("Response: \(String(describing: response.response))") // http url response
//      print("Result: \(response.result)")                         // response serialization result
//      
//      if let json = response.result.value {
//        print("JSON: \(json)") // serialized json response
//      }
//      
//      if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//        print("Data: \(utf8Text)") // original server data as UTF8 string
//      }
//    }
//  }
  
}

