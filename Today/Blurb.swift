//
//  Blurb.swift
//  Today
//
//  Created by ilteris on 4/10/15.
//  Copyright (c) 2015 ilteris. All rights reserved.
//

import Foundation
import Realm

class Blurb: RLMObject {
    dynamic var time = ""
    dynamic var summary = ""
    dynamic var temperature = ""
    dynamic var weatherIcon = ""
    dynamic var weatherDescription = ""

    
    
}

// Person model
class BlurbDate: RLMObject {
    dynamic var name = "" //Monday, Tuesday etc.
    dynamic var date = "" //23/4/15
    dynamic var blurbs = RLMArray(objectClassName: Blurb.className())
}
