//
//  PostCard.swift
//  ALO
//
//  Created by 이한결 on 2021/07/01.
//

import SwiftUI

struct PostCard: View {
    @ObservedObject var postCardService = PostCardService()
    
    @State private var animate = false
    private let duration: Double = 0.3
    private var animationScale: CGFloat{
        postCardService.isLiked ? 0.5 : 1.5
    }
    
    init(post: PostModel) {
        self.postCardService.post = post
        self.postCardService.hasLiksedPost()
    }
    
    
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack(spacing: 15) {
                
                Button(action: {
                    self.animate = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + self.duration, execute: {
                        self.animate = false
                        
                        if(self.postCardService.isLiked) {
                            self.postCardService.unlike()
                        } else {
                            self.postCardService.like()
                        }
                    })
                }) {
                    Image(systemName: (self.postCardService.isLiked) ? "heart.fill": "heart")
                        .frame(width: 25, height: 25, alignment: .center)
                        .foregroundColor((self.postCardService.isLiked) ? .red : .black)
                }.padding().scaleEffect(animate ? animationScale : 1)
                .animation(.easeIn(duration: duration))
                
                Image(systemName: "bubble.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25, alignment: .center)
                
                Spacer()
            }.padding(.leading, 16)
            
            if(self.postCardService.post.likeCount > 0 ) {
                Text("\(self.postCardService.post.likeCount) likes")
            }
            
            Text("View Comments")
                .font(.caption)
                .padding(.leading)
        }
    }
}
