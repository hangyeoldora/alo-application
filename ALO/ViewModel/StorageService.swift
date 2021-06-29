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
    
    static var storageRoot = storage.reference(forURL: "gs://alo-ios-7c6e7.appspot.com/profile/profile")
    
    static var storageProfile = storageRoot.child("profile")
    
    static func storageProfileId(userId:String) -> StorageReference {
        return storageProfile.child(userId)
    }
    
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
}
