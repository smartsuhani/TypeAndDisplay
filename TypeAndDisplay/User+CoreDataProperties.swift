//
//  User+CoreDataProperties.swift
//  TypeAndDisplay
//
//  Created by Devloper30 on 10/02/17.
//  Copyright © 2017 lanetteamLanet. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User");
    }

    @NSManaged public var name: String?
    @NSManaged public var username: String?
    @NSManaged public var password: String?

}
