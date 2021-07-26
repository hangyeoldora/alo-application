//
//  MarketPostService.swift
//  ALO
//
//  Created by 이한결 on 2021/07/01.
//

import Foundation
import Firebase
import SwiftUI

class MarketPostService : ObservableObject{
    
    @Published var market: MarketModel!
    @Published var isLiked = false
    
    func hasLiksedPost() {
        isLiked = (market.likes["\(Auth.auth().currentUser!.uid)"] == true)
            ? true: false
    }
    
    func like() {
        market.likeCount += 1
        isLiked = true
        
        MarketService.M_PostUserId(userId: market.ownerId).collection("m_posts").document(market.postId).updateData(["likeCount": market.likeCount, "\(Auth.auth().currentUser!.uid)": true])
        
        MarketService.M_Allposts.document(market.postId).updateData(["likeCount": market.likeCount, "\(Auth.auth().currentUser!.uid)": true])
        
        MarketService.M_TimelineUserId(userId: market.ownerId).collection("m_timeline").document(market.postId).updateData(["likeCount": market.likeCount, "\(Auth.auth().currentUser!.uid)": true])
    }
    
    // like heart
    
    func unlike() {
        market.likeCount -= 1
        isLiked = false
            
        MarketService.M_PostUserId(userId: market.ownerId).collection("m_posts").document(market.postId).updateData(["likeCount": market.likeCount, "\(Auth.auth().currentUser!.uid)": false])
        
        MarketService.M_Allposts.document(market.postId).updateData(["likeCount": market.likeCount, "\(Auth.auth().currentUser!.uid)": false])
        
        MarketService.M_TimelineUserId(userId: market.ownerId).collection("m_timeline").document(market.postId).updateData(["likeCount": market.likeCount, "\(Auth.auth().currentUser!.uid)": false])
    }
    
}
