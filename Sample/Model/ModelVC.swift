//
//  ModelVC.swift
//  Sample
//
//  Created by gowri anguraj on 21/10/19.
//  Copyright © 2019 gowri anguraj. All rights reserved.
//

import Foundation

struct data: Codable {
    var dogName : String?
    var description : String?
    var age : Int?
    var url : String?
   
    
    enum CodingsKey:String,CodingKey {
        case dogName = "dogName"
        case description = "description"
        case age = "age"
        case url = "url"
    }
    
}
