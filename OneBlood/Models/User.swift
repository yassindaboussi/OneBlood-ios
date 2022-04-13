//
//  User.swift
//  OneBlood
//
//  Created by Mac-Mini-2021 on 12/04/2022.
//

import Foundation

struct User: Decodable {
    let id : String
    let name, email, blood: String
    let age: Int
    let weight , adress : String
    let phone : Int
    let usertype, avatar: String
    let token : String
}


