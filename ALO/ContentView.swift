//
//  ContentView.swift
//  ALO
//
//  Created by 이한결 on 2021/06/29.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var session: SessionStore
    
    func listen(){
        session.listen()
    }

    var body: some View {
        
        Group{
            if(session.session != nil){
//                HomeView()// user인 경우?
                
                //testing start
                Home()
                //testing end
            } else {
                SignInView()
            }
        }.onAppear(perform: listen)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

