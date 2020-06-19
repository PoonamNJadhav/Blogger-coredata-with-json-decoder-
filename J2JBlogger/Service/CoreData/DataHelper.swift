//
//  DataHelper.swift
//  J2JBlogger
//
//  Created by Lawand, Poonam on 19/06/20.
//  Copyright © 2020 Lawand, Poonam. All rights reserved.
//

import Foundation
import CoreData

class DataHelper {
        
    static let shareInstance = DataHelper()
    let context = CoreDataManager.shared.persistentContainer.viewContext
        
    func parseAndSaveData(jsonData:Data) -> [ArticleViewModel]{
        var articleModelList = [ArticleViewModel]()
         do {
        // Parse JSON data
            let decoder = JSONDecoder()
            let articles = try JSONDecoder().decode([Article].self, from: jsonData)
            articleModelList += articles.map({return ArticleViewModel($0)})
            guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext
              else {
                   fatalError("Failed to decode Data")
               }
            decoder.userInfo[codingUserInfoKeyManagedObjectContext] = context
            try context.save()
         }
         catch(let ex)
         {
            print(ex.localizedDescription)
         }
            return articleModelList
        
        }
    //Fetch Article offline
    func fetchFromDataBase(_ pageNumer:Int,_ limit : Int) -> [ArticleViewModel]?{
            var articleModelList = [ArticleViewModel]()
            var articles:[Article] = []
                   let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Article")
                    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
                    fetchRequest.fetchLimit = limit
                    fetchRequest.fetchOffset = ((pageNumer-1) * limit)
                   do{
                       articles = try context.fetch(fetchRequest) as! [Article]
                   }catch{
                       print("fetch data error")
                   }
         articleModelList += articles.map({return ArticleViewModel($0)})
           return articleModelList
        }
  
}
