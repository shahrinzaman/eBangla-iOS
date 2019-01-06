//
//  Book.swift
//  eBangla
//
//  Created by Shahrin Zaman Abony on 6/1/19.
//  Copyright © 2019 Shahrin Zaman Abony. All rights reserved.
//

import Foundation


struct Book {
    
    let id:Int
    let name: String
    let writer: String
    let publications: String
    let imgUrlStr: String?
//    weak var category:Category?
    
}

extension Book{
    var imgUrl:URL?{
        guard let imgUrlStr = imgUrlStr else { return nil }
        return URL(string: imgUrlStr)
    }
}

extension Book: Hashable {
    
    // Synthesized by compiler
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
    
    // Default implementation from protocol extension
    var hashValue: Int {
        var hasher = Hasher()
        self.hash(into: &hasher)
        return hasher.finalize()
    }
}

