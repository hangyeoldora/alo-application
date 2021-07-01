//
//  Home.swift
//  ALO
//
//  Created by 이한결 on 2021/06/29.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var session: SessionStore
    @StateObject var HomeModel = HomeViewModel()
    
    var body: some View {
        
        ZStack{
            VStack(spacing: 10){
                HStack(spacing: 15){
                    Button(action: {
                            withAnimation(.easeIn){HomeModel.showMenu.toggle()}}, label: {
                        Image(systemName: "line.horizontal.3")
                            .font(.title)
                            .foregroundColor(Color.black)
                    })
                    
                    Text(HomeModel.userLocation == nil ? "Locating..." :  "Deliver To")
                        .foregroundColor(.black)
                    
                    Text(HomeModel.userAddress)
                        .font(.caption)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.black)
                    
                    Spacer()
                }
                .padding([.horizontal,.top])
                
                Divider()
                
                HStack(spacing: 15){
                    TextField("Search", text: $HomeModel.search)
                    
                    if HomeModel.search != ""{
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Image(systemName: "magnifyingglass")
                                .font(.title2)
                                .foregroundColor(.gray)
                        })
                        .animation(.easeIn)
                    }
                }.padding(.horizontal)
                .padding(.top, 10)
                
                Divider()
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    
                    VStack(spacing: 25){
                        ForEach(HomeModel.items){item in
                            
                            // Item View...
                            Text(item.item_name)
                        }
                    }
                })
            }
            
            // Side Menu.....
            HStack{
                SideMenu(homeData: HomeModel)
                    // Move Effect From Left....
                    .offset(x: HomeModel.showMenu ? 0 : -UIScreen.main.bounds.width / 1.6)
                
                Spacer(minLength: 0)
            }
            .background(Color.black.opacity(HomeModel.showMenu ? 0.3 : 0).ignoresSafeArea()
                // closing when Taps on outside...
                            .onTapGesture(perform: {
                                withAnimation(.easeIn){HomeModel.showMenu.toggle()}
                            })
            )
            
            
            // Non Closable Alert If permission Denied....
            
            if HomeModel.noLocation{
                Text("Please Enable Location Access In Setting To Further Move on!!!")
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.width - 100, height: 120)
                    .background(Color.white)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3).ignoresSafeArea())
            }
        }
         .onAppear(perform : {
            // calling location delegate....
            HomeModel.locationManager.delegate = HomeModel
//            HomeModel.locationManager.requestWhenInUseAuthorization()
//            // Modifying Info.plist...
        })
        Button(action: session.logout){
            Text("Logout").font(.title)
                .modifier(ButtonModifiers())
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
