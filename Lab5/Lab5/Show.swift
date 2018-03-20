//
//  Show.swift
//  Lab5
//
//  Created by Kaylin Shioshita on 3/19/18.
//  Copyright © 2018 Kaylin Shioshita. All rights reserved.
//

import Foundation
import RealmSwift

class Show: Object{
    @objc dynamic var name = ""
    @objc dynamic var days = ""
    @objc dynamic var watched = false
    
}
