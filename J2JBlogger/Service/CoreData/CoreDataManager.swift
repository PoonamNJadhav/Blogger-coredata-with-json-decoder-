//
//  CoreDataManager.swift
//  J2JBlogger
//
//  Created by Lawand, Poonam on 19/06/20.
//  Copyright © 2020 Lawand, Poonam. All rights reserved.
//


import CoreData

class CoreDataManager: NSObject{
    
    private override init() {
        super.init()
        
    }
    // Create a shared Instance
    static let shared = CoreDataManager()

    //MARK : Core Data Stack
    // Get the managed Object Context
    lazy var managedObjectContext = { () -> NSManagedObjectContext in
        return self.persistentContainer.viewContext
    }()
    // Persistent Container
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "ArticleDB")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            //container.viewContext.mergePolicy = NSMergePolicy.

            if let error = error as NSError? {
               fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
   
    
    // Save the data in Database
    func saveData(){
        
        let context = self.managedObjectContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // Save Data in background
    func saveDataInBackground() {
        
        persistentContainer.performBackgroundTask { (context) in
            
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
    }
    
}
public extension CodingUserInfoKey {
    // Helper property to retrieve the Core Data managed object context
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}
