import CoreData

protocol StorageManagerProtocol {
    func insert<T: NSManagedObject>(new object: T.Type) -> T?
    func find<T: NSManagedObject>(type: T.Type, sortDescriptors: [NSSortDescriptor]) -> [T] 
    func saveContext ()
}

final class StorageManager {
    // MARK: - Core Data stack

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Flickr")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}

// MARK: - StorageManagerProtocol

extension StorageManager: StorageManagerProtocol {
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            try? context.save()
        }
    }
    
    func insert<T: NSManagedObject>(new object: T.Type) -> T? {
        let context = persistentContainer.viewContext
        if let entityDescriptor = NSEntityDescription.entity(forEntityName: String(describing: T.self), in: context) {
            let entity = NSManagedObject(entity: entityDescriptor, insertInto: context) as? T
            return entity
        }
        return nil
    }
    
    func find<T: NSManagedObject>(type: T.Type, sortDescriptors: [NSSortDescriptor]) -> [T] {
        let context = persistentContainer.viewContext
        let request = T.fetchRequest()
        request.sortDescriptors = sortDescriptors
        
        do {
            let result = try context.fetch(request)
            return result as? [T] ?? []
        }catch {
            return []
        }
    }
}
