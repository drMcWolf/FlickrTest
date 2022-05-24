//
//  StorageManager.swift
//  FlickrApp
//
//  Created by Ivan Makarov on 24.05.2022.
//

import CoreData
import Foundation

protocol StorageManagerProtocol {
    func fetch() -> [SearchItem]
    func saveSearch(text: String)
}

final class StorageManager {
    // MARK: - Core Data stack
    private var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Flickr")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    private func save() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension StorageManager: StorageManagerProtocol {
    func fetch() -> [SearchItem] {
        let request = SearchItem.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        do {
            let result = try context.fetch(request)
            return result 
        }catch {
            return []
        }
    }
    
    func saveSearch(text: String) {
        let entity = NSEntityDescription.entity(forEntityName: "SearchItem",
                                     in: context)!
        
        let item = NSManagedObject(entity: entity,
                                     insertInto: context) as? SearchItem
        item?.date = Date()
        item?.text = text
        
        save()
    }
}
