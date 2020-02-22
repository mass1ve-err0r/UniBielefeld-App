//
//  Extensions.swift
//  Meine UniBi
//
//  Created by Saadat Baig on 14.02.20.
//  Copyright © 2020 Saadat Baig. All rights reserved.
//

import Foundation

// ext
extension String{
    
    // strip the tags and shit
    func noTags(isCash: Bool) -> String {
        var res = ""
        if (!isCash) {
            let regex = try! NSRegularExpression(pattern: "<(.*?)>(.*?)</(.*?)>")
            let range = NSMakeRange(0, self.count)
            res = regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "")
            return res
        } else {
            res = self.replacingOccurrences(of: #"<p class="bodytext">"#, with: "")
            return String(res.prefix(4))
        }
    }
    
    // reformat
    func cleanUp(isCash: Bool) -> String {
        let idx = self.index(self.startIndex, offsetBy: 0)
        var res = self
        while (true) {
            if (res.isEmpty) {
                break
            }
            if (res[idx] == " " || res[idx] == "\n") {
                res.remove(at: idx)
            } else {
                break
            }
        }
        if (isCash) {
            return String(res.prefix(4))
        } else {
            return res
        }
    }
    
    // replace HTML "special chars" with their unicode counterpart
    func reformatHTMLChars() -> String {
        var res = self
                    .replacingOccurrences(of: #"&nbsp;"#, with: "")
                    .replacingOccurrences(of: #"&quot;"#, with: "\"")
                    .replacingOccurrences(of: #"&amp;"#, with: "&")
        return res
    }
    
}
