//
//  Data.swift
//  Todoey
//
//  Created by Vu Nguyen on 6/16/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    dynamic var name : String  = ""
    let items = List<Item>()
}
