//
//  Category.swift
//  Todoey
//
//  Created by Vu Nguyen on 6/18/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = "#fafafa"
    let items = List<Item>()
}
