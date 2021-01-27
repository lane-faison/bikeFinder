//
//  PersistenceService.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/22/21.
//

import Foundation
import CoreData

class PersistenceService {
    
    private init() {}
    static let shared = PersistenceService()
    
    var context: NSManagedObjectContext { return persistentContainer.viewContext }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "bikeFinder")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func save(completion: @escaping () -> Void) {
        if context.hasChanges {
            do {
                try context.save()
                completion()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        } else {
            completion()
        }
    }
    
    func fetch<T: NSManagedObject>(_ type: T.Type, completion: @escaping ([T], Error?) -> Void) {
        let request = NSFetchRequest<T>(entityName: String(describing: type))
        
        do {
            let objects = try context.fetch(request)
            completion(objects, nil)
        } catch let error {
            print("Error fetching persisted objects: \(error)")
            completion([], error)
        }
    }
}
