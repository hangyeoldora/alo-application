//
//  Profile.swift
//  ALO
//
//  Created by 이한결 on 2021/06/29.
//

import SwiftUI
import FirebaseAuth
import SDWebImageSwiftUI

struct Profile: View {
    @EnvironmentObject var session : SessionStore
    @State private var selection = 1
    
    // 07.01 add func
    @ObservedObject var profileService = ProfileService()
    
    let threeColumns = [GridItem(), GridItem(), GridItem()]
    
    // 07.01 end

    
    var body: some View {
        
        ScrollView{
            VStack{
                ProfileHeader(user: self.session.session, postsCount: profileService.posts.count, following: $profileService.following, followers: $profileService.followers)
                Button(action: {}){
                    Text("Edit Profile")
                        .font(.title)
                        .modifier(ButtonModifiers())
                }.padding(.horizontal)
                
                Picker("", selection: $selection) {
                    Image(systemName: "circle.grid.2x2.fill").tag(0)
                    Image(systemName: "person.circle").tag(1)
                }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal)
                
                if selection == 0 {
                    LazyVGrid(columns: threeColumns) {
                        ForEach(self.profileService.posts, id:\.postId) {
                            (post) in
                            
                            WebImage(url: URL(string: post.mediaUrl)!)
                                .resizable()
                                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                .frame(width:UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.height/4).clipped()
                        }
                    }
                }
                else
                if (self.session.session == nil) { Text("")}
                else {
                    ScrollView{
                        VStack {
                            ForEach(self.profileService.posts, id:\.postId ) {
                                (post) in
                
                                PostCardImage(post: post)
                                PostCard(post: post)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: Button(action: {}){
            NavigationLink(destination: UserProfile()){
                Image(systemName: "magnifyingglass.circle")
            }
        }, trailing: Button(action: {
            session.logout()
        }){
            Image(systemName: "arrow.right.circle.fill")
        })
        .onAppear{
                self.profileService.loadUserPosts(userId: Auth.auth().currentUser!.uid)
        }
    }
}

