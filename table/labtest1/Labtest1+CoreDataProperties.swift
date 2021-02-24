//
//  Labtest1+CoreDataProperties.swift
//  table
//
//  Created by harpanth kaur on 2021-01-23.
//
//

import Foundation
import CoreData


extension Labtest1 {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Labtest1> {
        return NSFetchRequest<Labtest1>(entityName: "Labtest1")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var tution: Double
    @NSManaged public var termstartdate: Date?

}

extension Labtest1 : Identifiable {

}
