//
//  ProfileService.swift
//  ALO
//
//  Created by 이한결 on 2021/07/01.
//

import Foundation
import Firebase

class ProfileService: ObservableObject{
    @Published var posts: [PostModel] = []
    @Published var following = 0
    @Published var followers = 0
    
    //  Services-Authservice
    static var following = AuthService.storeRoot.collection("following")
    static var followers = AuthService.storeRoot.collection("followers")
    
    static func followingCollection(userid: String) -> CollectionReference{
        
        return following.document(userid).collection("following")
    }
    
    static func followersCollection(userid: String) -> CollectionReference{
        
        return followers.document(userid).collection("followers")
    }
    
    
    func loadUserPosts(userId: String) {
        //isLoading = true
        PostService.loadUserPosts(userId: userId) {
            //elf.isLoading = false
            (posts) in
                        
            self.posts = posts
            //self.splitted = self.posts.splited(into: 3)
        }
        follows(userId: userId)
        followers(userId: userId)
        // checkFollow(userId: userId)
        // updateFollowCount(userId: userId)
    }
    
    func follows(userId: String) {
        
        ProfileService.followingCollection(userid: userId).getDocuments{
            (querysnapshot, err) in
            
            if let doc = querysnapshot?.documents {
                self.following = doc.count
            }
        }
    }
    
    func followers(userId: String) {
        
        ProfileService.followersCollection(userid: userId).getDocuments{
            (querysnapshot, err) in
            
            if let doc = querysnapshot?.documents {
                self.followers = doc.count
            }
        }
    }
}
