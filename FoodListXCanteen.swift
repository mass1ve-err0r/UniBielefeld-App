//
//  unibiFood.swift
//  Meine UniBi
//
//  Created by Saadat Baig on 13.02.20.
//  Copyright © 2020 Saadat Baig. All rights reserved.
//

import Foundation
import Combine
import Alamofire
import SWXMLHash
import SwiftUI

class FoodListXCanteen: ObservableObject {
    // members
    @Published var weekMenu: [dayMenuObject] = [dayMenuObject]()
    var idIter = 0
    var idIter2 = 0
    
    // struct the outer shell "day"
    struct dayMenuObject: Identifiable {
        var id: Int
        var day: String
        var menus: [menuItem] = [menuItem]()
    }
    
    // truct the day's "menus"
    struct menuItem: Identifiable {
        var id: Int
        var menuType: String = ""
        var description: String = ""
        var priceStudent: String = ""
        var priceStaff: String = ""
        var priceGuest: String = ""
        var priceRefill: String = ""
        var priceUniversal: String = ""
        var additionalInfo: String = ""
    }
    
    // init
    init() {
        // get XML
        Alamofire.request("http://export.studierendenwerk-bielefeld.de/index.php?id=488",
                          method: .get,
                          parameters: nil)
        .response { response in
            print(response.data!) // if you want to check XML data in debug window.
            let xml = SWXMLHash.parse(response.data!)
            
            // loop through and collect all items
            for day in xml["plan"]["day"].all {
                var kID = self.idIter
                self.idIter += 1
                let kDay = day["weekday"].element?.text
                var currentDay = dayMenuObject(id: kID, day: kDay!)
                for menu in day["menus"]["menu"].all {
                    var kID2 = self.idIter2
                    self.idIter2 += 1
                    let kMenuType = self.correctString(str: menu["title"].element?.text)
                    let kDescription = self.correctString(str: menu["descriptopnHTML"].element?.text)
                        .replacingOccurrences(of: "<p>", with: "")
                        .replacingOccurrences(of: "</p>", with: "\n")
                        .replacingOccurrences(of: ":", with: ":\n")
                        .replacingOccurrences(of: #"<p class="bodytext">"#, with: "")
                        .noTags(isCash: false)
                        .cleanUp(isCash: false)
                    let kPriceStudent = self.correctString(str: menu["price"]["student"].element?.text)
                        .cleanUp(isCash: true)
                    let kPriceStaff = self.correctString(str: menu["price"]["servant"].element?.text)
                        .cleanUp(isCash: true)
                    let kPriceGuest = self.correctString(str: menu["price"]["guest"].element?.text)
                        .cleanUp(isCash: true)
                    let kPriceRefill = self.correctString(str: menu["price"]["refill"].element?.text)
                        .cleanUp(isCash: true)
                    let kPriceUniversal = self.correctString(str: menu["price"]["indi"].element?.text)
                        .cleanUp(isCash: false)
                        .noTags(isCash: true)
                    let kAdditionalInfo = self.correctString(str: menu["additionalInfo"].element?.text)
                        .cleanUp(isCash: false)
                    // generate object
                    var currentMenu = menuItem(id: kID2, menuType: kMenuType, description: kDescription, priceStudent: kPriceStudent, priceStaff: kPriceStaff, priceGuest: kPriceGuest, priceRefill: kPriceRefill, priceUniversal: kPriceUniversal, additionalInfo: kAdditionalInfo)
                    // add menu to array
                    currentDay.menus.append(currentMenu)
                }
                // add day to observable
                self.weekMenu.append(currentDay)
                self.idIter2 = 0
            }
        }
    }
    
    // helper
    func correctString(str: Optional<String>) -> String {
        // prematurely terminate if we just have "<![CDATA[]]>" (12)
        if (str!.count == 12) {
            return ""
        }
        // start & end idx are known since we cut the following:
        let start = str!.index(str!.startIndex, offsetBy: 9)  // front:   "<![CDATA[" (9)
        let end = str!.index(str!.endIndex, offsetBy: -4)     // back:    "]]>" (3)
        let range = start..<end
        let res = String(str![range])
        return res
    }
    // end
}
