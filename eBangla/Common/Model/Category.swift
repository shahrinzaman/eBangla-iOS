//
//  Category.swift
//  eBangla
//
//  Created by Shahrin Zaman Abony on 6/1/19.
//  Copyright © 2019 Shahrin Zaman Abony. All rights reserved.
//

import Foundation


class Category{
    let id:Int
    let name:String
    var books = Set<Book>()
    
    init(id:Int,name:String) {
        self.id = id
        self.name = name
    }
    
}
