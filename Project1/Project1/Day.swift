//
//  Day.swift
//  Project1
//
//  Created by Kaylin Shioshita on 3/4/18.
//  Copyright © 2018 Kaylin Shioshita. All rights reserved.
//

import Foundation
import RealmSwift

class Day: Object{
    
    @objc dynamic var notes = ""
    var steps = List<String>()
    @objc dynamic var condition = 0
    @objc dynamic var daycode = ""
    @objc dynamic var timeofday = -1
//    var condition = String()
    
}
