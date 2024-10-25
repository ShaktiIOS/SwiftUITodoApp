//
//  Todo+CoreDataProperties.swift
//  
//
//  Created by Shakti on 25/10/24.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var priority: String?

}

extension Todo : Identifiable {

}
