//
//  FoodWestend.swift
//  Meine UniBi
//
//  Created by Saadat Baig on 14.02.20.
//  Copyright © 2020 Saadat Baig. All rights reserved.
//

import Foundation
import Combine
import Alamofire
import SWXMLHash
import SwiftUI

class FoodListWestend: ObservableObject {
    // members
    @Published var weekMenu: [dayMenuObject] = [dayMenuObject]()
    var idIter = 0
    var idIter2 = 0
    
    // struct the outer shell "day"
    struct dayMenuObject: Identifiable {
        var id: Int = 0
        var day: String = ""
        var menus: [menuItem] = [menuItem]()
        
        // serialization
        mutating func convertToNSDataArray() -> [NSData] {
            var data: [NSData] = [NSData]()
            let x1 = NSData(bytes: &id, length: MemoryLayout<Int>.stride)
            let x2 = day.data(using: String.Encoding.utf8)! as NSData
            
            data.append(x1)
            data.append(x2)
            
            return data
        }
    }
    
    // truct the day's "menus"
    struct menuItem: Identifiable {
        var id: Int = 0
        var menuType: String = ""
        var description: String = ""
        var priceUniversal: String = ""
        var additionalInfo: String = ""
        
        // serialization
        mutating func convertToNSDataArray() -> [NSData] {
            var data: [NSData] = [NSData]()
            let x1 = NSData(bytes: &id, length: MemoryLayout<Int>.stride)  // MemoryLayout.stride == sizeof!
            let x2 = menuType.data(using: String.Encoding.utf8)! as NSData
            let x3 = description.data(using: String.Encoding.utf8)! as NSData
            let x4 = priceUniversal.data(using: String.Encoding.utf8)! as NSData
            let x5 = additionalInfo.data(using: String.Encoding.utf8)! as NSData
            data.append(x1)
            data.append(x2)
            data.append(x3)
            data.append(x4)
            data.append(x5)
            return data
        }
        
    }
    
    // init func
    init() {
        //super.init()
        load()
    }
    
    func load() {
        // get XML
        Alamofire.request("http://export.studierendenwerk-bielefeld.de/index.php?id=545",
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
                        .replacingOccurrences(of: #"<p class="bodytext">"#, with: "")
                        .replacingOccurrences(of: "</p>", with: "\n")
                        .replacingOccurrences(of: "</a>", with: "")
                        .replacingOccurrences(of: ":", with: ":\n")
                        .noTags(isCash: false)
                        .cleanUp(isCash: false)
                        .reformatHTMLChars()
                    let kPriceUniversal = self.correctString(str: menu["price"]["indi"].element?.text)
                        .cleanUp(isCash: false)
                        .noTags(isCash: true)
                    let kAdditionalInfo = self.correctString(str: menu["additionalInfo"].element?.text)
                        .cleanUp(isCash: false)
                    // generate object
                    var currentMenu = menuItem(id: kID2, menuType: kMenuType, description: kDescription, priceUniversal: kPriceUniversal, additionalInfo: kAdditionalInfo)
                    // add menu to array
                    currentDay.menus.append(currentMenu)
                }
                // add day to observable
                self.weekMenu.append(currentDay)
                self.idIter2 = 0
            }
        }
    }
    
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
    
    /*
    // NSCoding compliance
    func encode(with coder: NSCoder) {
        coder.encode(weekMenu, forKey: "weekMenu")
        coder.encode(idIter, forKey: "idIter")
        coder.encode(idIter2, forKey: "idIter2")
    }
    required init?(coder decoder: NSCoder) {
        self.weekMenu = (decoder.decodeObject(forKey: "weekMenu") as! [dayMenuObject])
        self.idIter = decoder.decodeObject(forKey: "idIter") as! Int
        self.idIter2 = decoder.decodeObject(forKey: "idIter2") as! Int
    }
    */
    
    // end
}
