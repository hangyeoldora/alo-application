//
//  MarketModel.swift
//  ALO
//
//  Created by 이한결 on 2021/07/01.
//

import Foundation

struct MarketModel: Encodable, Decodable{
    var title: String
    var price: Int
    var status: String
    var content: String
    var likes: [String: Bool]
    var geoLocation: String
    var ownerId: String
    var postId: String
    var username: String
    var profile: String
    var mediaUrl: String
    var date: Double
    var likeCount: Int
}
