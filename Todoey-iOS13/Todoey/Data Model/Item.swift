//
//  Item.swift
//  Todoey
//
//  Created by Vu Nguyen on 6/14/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object{
    dynamic var title: String = ""
    dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
