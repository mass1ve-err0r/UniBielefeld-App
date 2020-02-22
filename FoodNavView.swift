//
//  FoodNavView.swift
//  Meine UniBi
//
//  Created by Saadat Baig on 11.02.20.
//  Copyright © 2020 Saadat Baig. All rights reserved.
//

import SwiftUI

// Bistro Menu
struct BistroMorgenbreedeView: View {
    var body: some View {
        Text("Bistro")
    }
}

// Cafeteria Menu (X Building)
struct XCafeView: View {
    var body: some View {
        Text("Mensa X")
    }
}

// combined view
struct FoodSelectionView: View {
    
    // magic haxx, courtesy WWDC
    init() {
        // To remove only extra separators below the list:
        //UITableView.appearance().tableFooterView = UIView()

        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
    }
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: XCafeView()) {
                    Text("Cafeteria im X")
                }
                NavigationLink(destination: XCanteenView()) {
                    Text("Mensa im X")
                }
                NavigationLink(destination: WestendView()) {
                    Text("Westend")
                }
            }
            .navigationBarTitle("Standorte")
            Spacer()
        }
    }
}
// View
struct FoodNavView: View {
    var body: some View {
        FoodSelectionView()
    }
}

// Preview
struct FoodNavView_Previews: PreviewProvider {
    static var previews: some View {
        FoodNavView()
    }
}
