//
//  ExtrasView.swift
//  Meine UniBi
//
//  Created by Saadat Baig on 14.02.20.
//  Copyright © 2020 Saadat Baig. All rights reserved.
//

import SwiftUI

struct ExtrasView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: SBHauptbahnhof()) {
                    HStack {
                        Image(systemName: "clock.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .clipShape( Rectangle())
                            //.clipped()
                    }
                    Text("Fahrplan zum Dürkopp Tor 6")
                    .padding( .leading)
                }
                NavigationLink(destination: SBLohmannshof()) {
                    HStack {
                        Image(systemName: "clock.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            //.clipped()
                    }
                    Text("Fahrplan zum Lohmannshof")
                    .padding( .leading)
                }
                NavigationLink(destination: SBLohmannshof()) {
                    HStack {
                        Image(systemName: "rectangle.stack.person.crop.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            //.clipped()
                    }
                    Text("Personenverzeichnis")
                    .padding( .leading)
                }
                .navigationBarTitle("Extras")
            }
        }
    }
}

struct ExtrasView_Previews: PreviewProvider {
    static var previews: some View {
        ExtrasView()
    }
}
