//
//  ProfileHeader.swift
//  ALO
//
//  Created by 이한결 on 2021/06/30.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseAuth

struct ProfileHeader: View {
    
    var user: User?
    var postsCount: Int
    @Binding var following: Int
    @Binding var followers: Int
    
    var body: some View {
        HStack{
            

        VStack{
            if user != nil {
                WebImage(url: URL(string: user!.profileImageUrl)!)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100, alignment: .trailing)
                    .padding(.leading)
                
                Text(user!.username)
                    .font(.headline)
                    .bold()
                    .padding(.leading)
            } else {
                Color.init(red: 0.9, green: 0.9, blue: 0.9)
                    .frame(width: 100, height: 100, alignment: .trailing)
                    .padding(.leading)
            }
        }
            
        VStack{
            HStack{
                Spacer()
                VStack{
                    Text("Posts").font(.footnote)
                    Text("\(postsCount)").font(.title).bold()
                }.padding(.top)
                Spacer()
                VStack{
                    Text("Follwers").font(.footnote)
                    Text("\(followers)").font(.title).bold()
                }.padding(.top)
                Spacer()
                VStack{
                    Text("Follwers").font(.footnote)
                    Text("\(following)").font(.title).bold()
                }.padding(.top)
                Spacer()
            }
        }
        }
    }
}
