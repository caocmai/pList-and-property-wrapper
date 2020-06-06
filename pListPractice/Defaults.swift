//
//  Defaults.swift
//  pListPractice
//
//  Created by Cao Mai on 6/4/20.
//  Copyright © 2020 Make School. All rights reserved.
//

import UIKit

struct Defaults {

     static let token = "token"
     static let tokenKey = "tokenKey"

     struct Model {
         var token: String?

         init(token: String) {
           //complete the initializer
            self.token = token
         }
     }

     static var saveToken = { (token: String) in
       //complete the method
        UserDefaults.standard.set(token, forKey: tokenKey)

     }

     static var getToken = { () -> String? in
       //complete the method
        return UserDefaults.standard.string(forKey: tokenKey)
     }

     static func clearUserData() {
       //complete the method using removeObject
        UserDefaults.standard.removeObject(forKey: tokenKey)
     }
 }
