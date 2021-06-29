//
//  UserModel.swift
//  ALO
//
//  Created by 이한결 on 2021/06/29.
//

import Foundation

struct User: Encodable, Decodable{
    var uid:String
    var email:String
    var profileImageUrl:String
    var username:String
    var searchName:[String]
    var bio:String
}
