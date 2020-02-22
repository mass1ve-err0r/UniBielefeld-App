//
//  HomeView.swift
//  Meine UniBi
//
//  Created by Saadat Baig on 11.02.20.
//  Copyright © 2020 Saadat Baig. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            // DashboardView
            //Text("Content of Dashboard")
            DashboardView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
            }
            // MensaView
            FoodNavView()
        
                .tabItem {
                    Image(systemName: "rectangle.grid.1x2.fill")
                    Text("Essen")
             }
            // UniNavView
            UniNaviView()
            .tabItem {
               Image(systemName: "location.fill")
               Text("Navigation")
             }
            // SettingsView
            ExtrasView()
            .tabItem {
               Image(systemName: "plus.square.fill")
               Text("Extras")
             }
        }
        .accentColor(Color.green)
        .navigationBarBackButtonHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
