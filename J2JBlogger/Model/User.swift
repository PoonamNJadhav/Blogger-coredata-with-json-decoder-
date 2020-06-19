//
//  User.swift
//  J2JBlogger
//
//  Created by Lawand, Poonam on 19/06/20.
//  Copyright © 2020 Lawand, Poonam. All rights reserved.
//

import Foundation
import CoreData



class User : NSManagedObject, Codable {
@NSManaged var id : String?
@NSManaged var blogId : String?
@NSManaged var createdAt : String?
@NSManaged var name : String?
@NSManaged var avatar : String?
@NSManaged var lastname : String?
@NSManaged var city : String?
@NSManaged var designation : String?
@NSManaged var about : String?

enum CodingKeys: String, CodingKey {

    case id = "id"
    case blogId = "blogId"
    case createdAt = "createdAt"
    case name = "name"
    case avatar = "avatar"
    case lastname = "lastname"
    case city = "city"
    case designation = "designation"
    case about = "about"
}

    //Mark : Decodable
    required convenience init(from decoder: Decoder) throws {
       
          let context = CoreDataManager.shared.persistentContainer.viewContext
            guard let entity = NSEntityDescription.entity(forEntityName: "User", in: context) else {
                fatalError("Failed to decode User")
            }
        self.init(entity: entity, insertInto: context)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        blogId = try values.decodeIfPresent(String.self, forKey: .blogId)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
        lastname = try values.decodeIfPresent(String.self, forKey: .lastname)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        designation = try values.decodeIfPresent(String.self, forKey: .designation)
        about = try values.decodeIfPresent(String.self, forKey: .about)
}
    //Mark : Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
         try container.encode(self.id, forKey: .id)
         try container.encode(self.blogId, forKey: .blogId)
         try container.encode(self.createdAt, forKey: .createdAt)
         try container.encode(self.name, forKey: .name)
         try container.encode(self.avatar, forKey: .avatar)
         try container.encode(self.lastname, forKey: .lastname)
         try container.encode(self.city, forKey: .city)
         try container.encode(self.designation, forKey: .designation)
         try container.encode(self.about, forKey: .about)
    }
    
    
    
}
 
