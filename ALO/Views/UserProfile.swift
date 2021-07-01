//
//  UserProfile.swift
//  ALO
//
//  Created by 이한결 on 2021/07/01.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserProfile: View {
    @State private var value: String = ""
    @State var users: [User] = []
    @State var isLoading = false
    
    func searchUsers(){
        isLoading = true
        
        SearchService.searchUser(input: value) {
            (users) in
            self.isLoading = false
            self.users = users
        }
    }
    
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading){
                // value 변경 시, 항상 부름
                SearchBar(value: $value).padding()
                    .onChange(of: value, perform: {
                        new in
                        
                        searchUsers()
                    })
                if !isLoading {
                    ForEach(users, id:\.uid) {
                        user in
                        
                        HStack{
//                            Text("\(user.email)")
                            WebImage(url: URL(string: user.profileImageUrl)!)
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(width: 60, height: 60, alignment: .trailing)
                                .padding()
                            Text(user.username).font(.subheadline).bold()
                        }
                        Divider().background(Color.black)
                    }
                }
            }
        }.navigationTitle("User Search")
    }
}

