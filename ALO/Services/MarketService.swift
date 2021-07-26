//
//  MarketService.swift
//  ALO
//
//  Created by 이한결 on 2021/07/01.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class MarketService {
    
    static var M_Posts = AuthService.storeRoot.collection("m_posts")
    
    static var M_Allposts = AuthService.storeRoot.collection("m_allPosts")
    
    static var M_Timeline = AuthService.storeRoot.collection("m_timeline")
    
    static func M_PostUserId(userId: String) -> DocumentReference {
        return M_Posts.document(userId)
    }
    
    static func M_TimelineUserId(userId: String) -> DocumentReference {
        return M_Timeline.document(userId)
    }
    
    static func uploadMarket(title: String, price: Int, imageData: Data, status: String, content: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        guard let userId = Auth.auth().currentUser?.uid else{
            return
        }
        
        let postId = MarketService.M_PostUserId(userId: userId).collection("m_posts").document().documentID
        let storageMarketRef = StorageService.storageMarketId(postId: postId)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        StorageService.saveMarketPhoto(userId: userId, title: title, price: price, status: status, content: content, postId: postId, imageData: imageData, metadata: metadata, storageMarketRef: storageMarketRef, onSuccess: onSuccess, onError: onError)
        
    }
    
    static func loadUserMarket(userId: String, onSuccess: @escaping(_ m_posts: [MarketModel]) -> Void) {
        
        MarketService.M_PostUserId(userId: userId).collection("m_posts").getDocuments{
            (snapshot, error) in
            
            guard let snap = snapshot else {
                print("Error")
                return
            }
            
            var m_posts = [MarketModel] ()
            
            for doc in snap.documents {
                let dict = doc.data()
                guard let decoder = try? MarketModel.init(fromDictionary: dict)
                
                else {
                    return
                }
                m_posts.append(decoder)
            }
            onSuccess(m_posts)
        }
    }
    
}
