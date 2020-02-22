//
//  WestendView.swift
//  Meine UniBi
//
//  Created by Saadat Baig on 14.02.20.
//  Copyright © 2020 Saadat Baig. All rights reserved.
//

import SwiftUI

struct WestendView: View {
    // data
    @ObservedObject var food = FoodListWestend()
    @State var showingDetail = false
    
    var body: some View {
            if (self.food.weekMenu.count != 0) {
                test(array: food.weekMenu)
                test2()
                return AnyView(
                    List {
                        ForEach(food.weekMenu, id: \.id) { day in
                            ForEach(day.menus, id: \.id) { menu in
                                DayMenuWestend(dayName: day.day,
                                        type: menu.menuType,
                                        description: menu.description,
                                        priceU: menu.priceUniversal,
                                        addInf: menu.additionalInfo)
                            }
                        }
                    }
                    .navigationBarTitle("Westend", displayMode: .inline)
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

// debug
extension View {
    
    func test (array: [FoodListWestend.dayMenuObject])  {
        /*
        let defaults = UserDefaults.standard
        let td = try? NSKeyedArchiver.archivedData(withRootObject: array, requiringSecureCoding: false)
        print("Data test")
        print(td)
        defaults.set(try! NSKeyedArchiver.archivedData(withRootObject: array, requiringSecureCoding: false), forKey: "arrayTest")
         */
        
        var test = UserDefaults.standard.array(forKey: "westendFood") as! [FoodListWestend.dayMenuObject]
        test = array
        UserDefaults.standard.set(test, forKey: "westendFood")
    }
    
    func test2() {
        var test2 = UserDefaults.standard.array(forKey: "westendFood") as! [FoodListWestend.dayMenuObject]
        print(test2)
    }
}
// debug

// customized base daymenu
struct DayMenuWestend: View{
        var dayName: String = "test DAY"
        var type: String = "TYPE"
        var description: String = "Sample description which is very long bruh"
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
            if (priceU.isEmpty) {
                return ""
            } else {
                res += priceU + " €"
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
struct WestendView_Previews: PreviewProvider {
    static var previews: some View {
        WestendView()
    }
}
