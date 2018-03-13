//
//  Data.swift
//  Project1
//
//  Created by Kaylin Shioshita on 3/4/18.
//  Copyright © 2018 Kaylin Shioshita. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object{
    
    var data=List<Day>()
    @objc dynamic var code=""
}
