//
//  Item.swift
//  Todoey
//
//  Created by Naz on 9/15/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

class Item {
    
    var item: String = ""
    var done: Bool = false
    
    init(item: String, done: Bool) {
        self.item = item
        self.done = done
    }
}
