//
//  Food_XCanteen.swift
//  Meine UniBi
//
//  Created by Saadat Baig on 13.02.20.
//  Copyright © 2020 Saadat Baig. All rights reserved.
//

import SwiftUI

struct XCanteenView: View {
    // data
    @ObservedObject var food = FoodListXCanteen()
    @State var showingDetail = false

    var body: some View {
        if (self.food.weekMenu.count != 0) {
            return AnyView(
                List {
                    ForEach(food.weekMenu, id: \.id) { day in
                        ForEach(day.menus, id: \.id) { menu in
                            DayMenu(dayName: day.day,
                                    type: menu.menuType,
                                    description: menu.description,
                                    priceS: menu.priceStudent,
                                    priceM: menu.priceStaff,
                                    priceG: menu.priceGuest,
                                    priceR: menu.priceRefill,
                                    priceU: menu.priceUniversal,
                                    addInf: menu.additionalInfo)
                        }
                    }
                }
                .navigationBarTitle("Mensa X", displayMode: .inline)
                .navigationBarItems(trailing:
                    HStack {
                        Button(action: {
                            self.showingDetail.toggle()
                        }) {
                            Image(systemName: "lightbulb.fill")
                            //.imageScale( .large)
                        }
                        .sheet(isPresented: $showingDetail, onDismiss: {self.showingDetail = false}) {
                            sampleView()
                        }
                    }
                )
            )
        } else {
            return AnyView(
                Text("Loading...")
            )
        }
    }
}

struct sampleView: View {
    var body: some View {
        Text("Hello, this is a iso13 Modal")
    }
}

struct DayMenu: View {
    var dayName: String = "test DAY"
    var type: String = "TYPE"
    var description: String = "Sample description which is very long bruh"
    var priceS: String = "/"
    var priceM: String = "/"
    var priceG: String = "/"
    var priceR: String = "/"
    var priceU: String = "/"
    var addInf: String = ""
    var body: some View {
        VStack {
            HStack{
                VStack(alignment: .leading) {
                    Text(dayName)
                        .font(.headline)
                        .foregroundColor(Color.black)
                    Text(type)
                        .font(.headline)
                        .fontWeight(.black)
                        .foregroundColor(Color.black)
                        .lineLimit(3)
                    Text(description.uppercased())
                        .font( .caption)
                        .foregroundColor(Color.black)
                    Spacer()
                    Text(priceString())
                        .font( .subheadline)
                    Spacer()
                    Text(aiString())
                        .italic()
                        .font( .subheadline)
                }
                .layoutPriority(100)
                Spacer()
                Spacer()
            }
        .padding()
        }
        .cornerRadius(10)
        .background(
            RoundedRectangle(cornerRadius: 10)
            .foregroundColor(Color.white)
            .shadow(radius: 5)
        )
        .padding([.top, .horizontal])
    }
    
    func priceString() -> String {
        var res = "Preis: "
        if (priceS.isEmpty && priceU.isEmpty) {
            return ""
        }
        if (priceS.isEmpty) {
            res += priceU + "€"
        } else {
            res += priceS + " € / " + priceM + " €/ " + priceG + "€"
        }
        return res
    }
    
    func aiString() -> String {
        var res = "Anmerkungen: "
        if (addInf.isEmpty) {
            return ""
        } else {
            res += addInf
            return res
        }
    }
}

// Preview
struct Food_XCanteen_Previews: PreviewProvider {
    static var previews: some View {
        DayMenu()
    }
}
