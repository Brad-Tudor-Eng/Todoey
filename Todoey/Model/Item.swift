//
//  Item.swift
//  Todoey
//
//  Created by Bradley Tudor on 5/11/19.
//  Copyright © 2019 Bradley Tudor. All rights reserved.
//

import Foundation

class Item {
    var title: String
    var checked: Bool
    
    init(title: String = "", checked: Bool = false) {
        self.title = title
        self.checked = checked
    }
    
}
