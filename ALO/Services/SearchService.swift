//
//  SearchService.swift
//  ALO
//
//  Created by 이한결 on 2021/07/01.
//

import Foundation
import FirebaseAuth

class SearchService {
    
    static func searchUser(input: String, onSuccess: @escaping (_ user: [User]) -> Void) {
        
        // users database 접근, 안에 searchName 꺼내기
        AuthService.storeRoot.collection("users").whereField("searchName", arrayContains: input.lowercased().removeWhiteSpace()).getDocuments{
            (querySnapshot, err) in
            
            guard let snap = querySnapshot else {
                print("error")
                return
            }
            
            var users = [User]()
            for document in snap.documents {
                let dict = document.data()
                guard let decoded = try? User.init(fromDictionary: dict)
                    else {return}
                
                if decoded.uid != Auth.auth().currentUser!.uid {
                    users.append(decoded)
                }
                
                onSuccess(users)
            }
        }
    }
}
