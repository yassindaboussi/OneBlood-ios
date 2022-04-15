//
//  User.swift
//  OneBlood
//
//  Created by Mac-Mini-2021 on 12/04/2022.
//

import Foundation

struct User: Decodable {
    var id : String
    var name, email, blood: String
    var age: Int
    var weight , adress : String
    var phone : Int
    var usertype, avatar: String
    var token : String
}


