//
//  Media.swift
//  J2JBlogger
//
//  Created by Lawand, Poonam on 19/06/20.
//  Copyright © 2020 Lawand, Poonam. All rights reserved.
//

import Foundation
import CoreData
 
class Media : NSManagedObject, Codable {
    @NSManaged var id : String?
    @NSManaged var blogId : String?
    @NSManaged var createdAt : String?
    @NSManaged var image : String?
    @NSManaged var title : String?
    @NSManaged var url : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case blogId = "blogId"
        case createdAt = "createdAt"
        case image = "image"
        case title = "title"
        case url = "url"
    }

     required convenience init(from decoder: Decoder) throws {
          
           let context = CoreDataManager.shared.persistentContainer.viewContext
               guard let entity = NSEntityDescription.entity(forEntityName: "Media", in: context) else {
                   fatalError("Failed to decode User")
               }

           self.init(entity: entity, insertInto: context)
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decodeIfPresent(String.self, forKey: .id)
            blogId = try values.decodeIfPresent(String.self, forKey: .blogId)
            createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
            image = try values.decodeIfPresent(String.self, forKey: .image)
            title = try values.decodeIfPresent(String.self, forKey: .title)
            url = try values.decodeIfPresent(String.self, forKey: .url)
    }
   
    //Mark : Encodable
       public func encode(to encoder: Encoder) throws {
           var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(self.id, forKey: .id)
            try container.encode(self.blogId, forKey: .blogId)
            try container.encode(self.createdAt, forKey: .createdAt)
            try container.encode(self.image, forKey: .image)
            try container.encode(self.title, forKey: .title)
            try container.encode(self.url, forKey: .url)
           
       }
       
}

