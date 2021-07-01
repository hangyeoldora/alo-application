//
//  PostModel.swift
//  ALO
//
//  Created by 이한결 on 2021/06/29.
//

import Foundation

struct PostModel: Encodable, Decodable{
    
    var caption: String
    var likes: [String: Bool] // dict
    var geoLocation: String
    var ownerId: String
    var postId: String
    var username: String
    var profile: String
    var mediaUrl: String //image url
    var date: Double
    var likeCount: Int
}
