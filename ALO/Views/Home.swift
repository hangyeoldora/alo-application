//
//  Home.swift
//  ALO
//
//  Created by 이한결 on 2021/07/01.
//

import SwiftUI

struct Home: View {
    
    @State var selectedTab = scroll_Tabs[0]
    @Namespace var animation
    
    var body: some View {
        VStack(spacing: 0){
            ZStack{
                HStack(spacing: 15){
                    Button(action: {}, label: {
                        Image(systemName: "line.horizontal.3.decrease")
                            .font(.title)
                            .foregroundColor(.black)
                    })
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {}, label: {
                        Image(systemName: "magnifyingglass")
                            .font(.title)
                            .foregroundColor(.black)
                    })
                    
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
                        Button(action: {}, label: {
                            Image(systemName: "cart")
                                .font(.title)
                                .foregroundColor(.black)
                        })
                        Circle()
                            .fill(Color.red)
                            .frame(width: 15, height: 15)
                            .offset(x: 5, y: -10)
                    })
                }
                
                Text("Main")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
            }
            .padding()
            
            .background(Color.white)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
            
            ScrollView(.vertical, showsIndicators: false, content: {
                
                VStack{
                    HStack{
                        Text("판매 상품")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    .padding(.bottom, 10)
                    
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        
                        HStack(spacing: 15){
                            
                            ForEach(scroll_Tabs, id: \.self){
                                tab in
                                
                                // Tab Button....
                                
                                TabButton2(title: tab, selectedTab: $selectedTab, animation: animation)
                            }
                        }.padding(.horizontal)
                        .padding(.top, 10)
                    })
                    
                    //grid
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2), spacing: 15){
                        
                        ForEach(bags){
                            bag in
                            
                            BagView(bagData: bag, animation: animation)
                        }
                    }
                    .padding()
                    .padding(.top,10 )
                    
                    //grid end
                }
            })
        }
        .background(Color.black.opacity(0.05).ignoresSafeArea(.all, edges: .all))
        // 맨 상단 빈 공간 없애기
        .ignoresSafeArea(.all, edges: .top)
        .ignoresSafeArea(.all, edges: .bottom)
    }
}
