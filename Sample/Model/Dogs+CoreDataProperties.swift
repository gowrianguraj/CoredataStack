//
//  Dogs+CoreDataProperties.swift
//  
//
//  Created by gowri anguraj on 15/12/19.
//
//

import Foundation
import CoreData


extension Dogs {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dogs> {
        return NSFetchRequest<Dogs>(entityName: "Dogs")
    }

    @NSManaged public var dogName: String?
    @NSManaged public var discription: String?
    @NSManaged public var age: Int64
    @NSManaged public var url: String?

}
