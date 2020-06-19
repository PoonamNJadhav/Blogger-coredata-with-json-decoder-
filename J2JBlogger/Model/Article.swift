//
//  Article.swift
//  J2JBlogger
//
//  Created by Lawand, Poonam on 17/06/20.
//  Copyright © 2020 Lawand, Poonam. All rights reserved.
//

import Foundation
import CoreData

class Article : NSManagedObject, Codable {
    @NSManaged public var comments: String?
    @NSManaged public var content: String?
    @NSManaged public var createdAt: String?
    @NSManaged public var id: Int16
    @NSManaged public var likes: String?
    @NSManaged public var user: Set<User>?
    @NSManaged public var media: Set<Media>?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt = "createdAt"
        case content = "content"
        case comments = "comments"
        case likes = "likes"
        case media = "media"
        case user = "user"
    }
    //Mark : Decodable
    required convenience init(from decoder: Decoder) throws {
       
        let context = CoreDataManager.shared.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Article", in: context) else {
            fatalError("Failed to decode User")
        }
        self.init(entity: entity, insertInto: context)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try (Int16(container.decodeIfPresent(String.self, forKey: .id) ?? "") ?? 0)
        self.createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt) ?? ""
        self.content = try container.decodeIfPresent(String.self, forKey: .content)
        self.comments = (try container.decodeIfPresent(Int.self, forKey: .comments) ?? 0).roundedWithAbbreviations
        self.likes = (try container.decodeIfPresent(Int.self, forKey: .likes) ??  0).roundedWithAbbreviations
        self.media =  try container.decodeIfPresent(Set<Media>.self, forKey: .media) ?? []
        self.user = try container.decodeIfPresent(Set<User>.self, forKey: .user) ?? []
        
    }
     //Mark : Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.id, forKey: .id)
        try container.encode(self.createdAt, forKey: .createdAt)
        try container.encode(self.content, forKey: .content)
        try container.encode(self.comments, forKey: .comments)
        try container.encode(self.likes, forKey: .likes)
        try container.encode(self.user, forKey: .user)
        try container.encode(self.media, forKey: .media)
     
    }
}



