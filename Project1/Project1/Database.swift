//
//  Database.swift
//  Project1
//
//  Created by Kaylin Shioshita on 3/10/18.
//  Copyright © 2018 Kaylin Shioshita. All rights reserved.
//

import Foundation
import RealmSwift

class Database: Object {

    @objc dynamic var notes = ""
    var steps = List<String>()
    @objc dynamic var condition = 0
    @objc dynamic var daycode = ""
    @objc dynamic var timeofday = 0
//    @objc dynamic var dataList: Data?
    
}
