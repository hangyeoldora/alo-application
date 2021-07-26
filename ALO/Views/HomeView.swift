//
//  HomeView.swift
//  ALO
//
//  Created by 이한결 on 2021/06/29.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        
        VStack{
//            Button(action: session.logout){
//                Text("Logout").font(.title)
////                    .modifier(ButtonModifiers())
//                    .background(Color.pink.opacity(3))
//                    .font(.system(size:20, weight: .bold))
//                    .frame(width:150, height:100, alignment: .center)
//                    .foregroundColor(.black)
//            }
            CustomTabView()
        }
    }
}

var tabs = ["house.fill", "magnifyingglass", "camera.viewfinder", "heart.fill", "person.fill"]

struct CustomTabView: View {
    @State var selectedTab = "house.fill"
    @State var edge = UIApplication.shared.windows.first?.safeAreaInsets
    
    var body: some View{

    //ios 14 스와이프 기능 추가 14미만이면 스위치 등
    ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){
        
        NavigationView{
            TabView(selection: $selectedTab) {
                Home()
                    .tag("house.fill")
                    .navigationBarHidden(true)
                    .ignoresSafeArea(.all, edges: .bottom)
                Search()
                    .tag("magnifyingglass")
                MarketPost()
                    .tag("camera.viewfinder")
                Notifications()
                    .tag("heart.fill")
                Profile()
                    .tag("person.fill")
            }
        }.accentColor(.pink)
        .navigationBarHidden(true)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .ignoresSafeArea(.all, edges: .bottom)
        
        
        HStack(spacing: 0) {
            ForEach(tabs, id: \.self) {
                image in
                TabButton(image: image, selectedTab: $selectedTab)
                
                // 동일 간격
                if image != tabs.last {
                    Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                }
            }
        }
        .padding(.horizontal, 25)
        .padding(.vertical, 5)
        .background(Color.white)
        .clipShape(Capsule())
        .shadow(color: Color.black.opacity(0.15), radius: 5, x: 5, y: 5)
        .shadow(color: Color.black.opacity(0.15), radius: 5, x: -5, y: -5)
        .padding(.horizontal)
        .padding(.bottom, edge!.bottom == 0 ? 20: 0)
    }
    .ignoresSafeArea(.keyboard, edges: .bottom)
    .background(Color.black.opacity(0.05).ignoresSafeArea(.all, edges: .all))
}
}

struct TabButton: View {
    var image: String
    
    @Binding var selectedTab: String
    
    var body: some View{
        Button(action: {selectedTab = image}) {
            Image(systemName: "\(image)")
                .foregroundColor(selectedTab == image ? Color(#colorLiteral(red: 0.8897715211, green: 0.4968054295, blue: 0.5575011969, alpha: 1)): Color.gray)
                .padding()
        }
    }
}
