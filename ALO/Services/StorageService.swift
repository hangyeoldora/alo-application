//
//  StorageService.swift
//  ALO
//
//  Created by 이한결 on 2021/06/29.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage

class StorageService {

    static var storage = Storage.storage()
    
    static var storageRoot = storage.reference()
//    storage.reference(forURL: "gs://alo-ios-7c6e7.appspot.com/profile/profile")
    static var storageProfile = storageRoot.child("profile")
    
    // Market DB
//    1. 변수 생성
//    2. func storage~Id 생성
    static var storageMarket = storageRoot.child("m_posts")
    
    static func storageMarketId(postId:String) -> StorageReference {
        return storagePost.child(postId)
    }

    
    // Post DB
//    1. 변수 생성
//    2. func storage~Id 생성
    static var storagePost = storageRoot.child("posts")
    
    static func storagePostId(postId:String) -> StorageReference {
        return storagePost.child(postId)
    }

    static func storageProfileId(userId:String) -> StorageReference {
        return storageProfile.child(userId)
    }
    
    // profile 내용 저장하는 함수 생성 시작
    static func saveProfileImage(userId:String, username:String, email:String, imageData: Data, metaData:StorageMetadata, storageProfileImageRef: StorageReference, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
      
        storageProfileImageRef.putData(imageData, metadata: metaData) {
            (StorageMetadata, error) in
            
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            storageProfileImageRef.downloadURL{
                (url, error) in
                if let metaImageUrl = url?.absoluteString {
                    if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                        changeRequest.photoURL = url
                        changeRequest.displayName = username
                        changeRequest.commitChanges{
                            (error) in
                            if error != nil {
                                onError(error!.localizedDescription)
                                return
                            }
                        }
                    }
                    let firestoreUserId = AuthService.getUserId(userId: userId)
                    let user = User.init(uid: userId, email: email, profileImageUrl: metaImageUrl, username: username, searchName: username.splitString(), bio: "")
                    guard let dict = try?user.asDictionary() else {return}
                    
                    firestoreUserId.setData(dict){
                        (error) in
                        if error != nil {
                            onError(error!.localizedDescription)
                        }
                    }
                    onSuccess(user)
                }
            }
        }
    }
    // profile 내용 저장하는 함수 생성 끝
    
    // post 내용 저장하는 함수 생성 시작, 해당 변수를 postservice 함수 내 넣기
    static func savePostPhoto(userId:String, caption: String, postId: String, imageData: Data, metadata:StorageMetadata,
        storagePostRef: StorageReference, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        
        storagePostRef.putData(imageData, metadata: metadata) {
            (StorageMetadata, error) in
            
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            storagePostRef.putData(imageData, metadata: metadata){
                
                (StorageMetadata, error) in
                
                if error != nil {
                    onError(error!.localizedDescription)
                    return
                }
                
                storagePostRef.downloadURL{
                    (url, error) in
                    if let metaImageUrl = url?.absoluteString {
                        let firestorePostRef = PostService.PostsUserId(userId: userId).collection("posts").document(postId)
                        
                        let post = PostModel.init(caption: caption, likes: [:], geoLocation: "", ownerId: userId, postId: postId, username: Auth.auth().currentUser!.displayName!, profile: Auth.auth().currentUser!.photoURL!.absoluteString, mediaUrl: metaImageUrl, date: Date().timeIntervalSince1970, likeCount: 0)
                        
                        guard let dict = try? post.asDictionary() else {return}
                        
                        firestorePostRef.setData(dict) {
                            (error) in
                            if error != nil {
                                onError(error!.localizedDescription)
                                return
                            }
                            
                            PostService.timelineUserId(userId: userId).collection("timeline").document(postId).setData(dict)
                            
                            PostService.AllPosts.document(postId).setData(dict)
                            onSuccess()
                        }
                    }
                }
            }
        }
    
    // post 내용 저장하는 함수 생성 끝
    }
    
    
    // market 내용 저장하는 함수 생성 시작, 해당 변수를 postservice 함수 내 넣기
    static func saveMarketPhoto(userId:String, title: String, price: Int, status: String, content: String, postId: String, imageData: Data, metadata:StorageMetadata,
                                storageMarketRef: StorageReference, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        
        storageMarketRef.putData(imageData, metadata: metadata) {
            (StorageMetadata, error) in
            
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            storageMarket.putData(imageData, metadata: metadata){
                
                (StorageMetadata, error) in
                
                if error != nil {
                    onError(error!.localizedDescription)
                    return
                }
                
                storageMarket.downloadURL{
                    (url, error) in
                    if let metaImageUrl = url?.absoluteString {
                        let firestoreMarketRef = MarketService.M_PostUserId(userId: userId).collection("m_posts").document(postId)
                        
                        let m_post = MarketModel.init(title: title, price: 0, status: status, content: content, likes: [:], geoLocation: "", ownerId: userId, postId: postId, username: Auth.auth().currentUser!.displayName!, profile: Auth.auth().currentUser!.photoURL!.absoluteString, mediaUrl: metaImageUrl, date: Date().timeIntervalSince1970, likeCount: 0)
                        
                        guard let dict = try? m_post.asDictionary() else {return}
                        
                        firestoreMarketRef.setData(dict) {
                            (error) in
                            if error != nil {
                                onError(error!.localizedDescription)
                                return
                            }
                            
                            MarketService.M_TimelineUserId(userId: userId).collection("m_timeline").document(postId).setData(dict)
                            
                            MarketService.M_Allposts.document(postId).setData(dict)
                            onSuccess()
                        }
                    }
                }
            }
        }
    
    // post 내용 저장하는 함수 생성 끝
    }
}
