//
//  unibiRSS.swift
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

class unibiRSSList: ObservableObject {
    // members
    @Published var contentList: [FeedObject] = [FeedObject]()

    // struct the data
    struct FeedObject: Identifiable{
        var id: Int
        var link: String = ""
        var title: String = ""
        var category: String = ""
        var publishedDate: String = ""
    }

    // fetch items
    init() {
        // get XML
        Alamofire.request("https://ekvv.uni-bielefeld.de/blog/uninews/feed/entries/atom",
                          method: .get,
                          parameters: nil)
        .response { response in
            print(response.data!) // if you want to check XML data in debug window.
            let xml = SWXMLHash.parse(response.data!)
            // loop through and collect 10 items
            for idx in 0...9 {
                let fLink = xml["feed"]["entry"][idx]["id"].element?.text
                let fTitle = xml["feed"]["entry"][idx]["title"].element?.text
                let fCategory = xml["feed"]["entry"][idx]["author"]["name"].element?.text
                let fDate = xml["feed"]["entry"][idx]["published"].element?.text
                var feedItem = FeedObject(id: idx, link: fLink!, title: fTitle!, category: fCategory!, publishedDate: fDate!)
                self.contentList.append(feedItem)
            }
        }
    }
    // end
}
