//
//  DatabaseManager.swift
//  FashionPeople
//
//  Created by Andrey on 25.06.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit
import CoreData

final class DatabaseManager: NSObject {
    
    static var shared = DatabaseManager()
    
    //MARK: - Property
    
    var context: NSManagedObjectContext!
    
    //MARK: - Initialization
    
    private override init() { super.init()
        context = getContext()
    }
    
    //MARK: - Functions
    
    public func saveContext() {
        do {try context.save()} catch {print(error.localizedDescription)}
    }
    
    public func addToDatabase(_ nameEntity: String, _ dictionaryProperty: [String: Any]) {
        let object = NSEntityDescription.insertNewObject(forEntityName: nameEntity, into: context)
        setPropertyForObject(object, dictionaryProperty)
    }
    
    public func getObjectsFromDatabase(_ nameEntity: String) -> [NSManagedObject] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: nameEntity)
        do {
            return try context.fetch(request) as! [NSManagedObject]
        } catch {
            return [NSManagedObject()]
        }
    }
    
    public func getObjectsFromDatabase(_ nameEntity: String, _ key: String, _ value: String) -> [NSManagedObject] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: nameEntity)
        request.predicate = NSPredicate(format: key + " = %@", value)
        do{
            let results = try context.fetch(request) as! [NSManagedObject]
            if !results.isEmpty {return results}
        } catch {print(error.localizedDescription)}
        
        return [NSManagedObject]()
    }
    
    public func removeAll(_ nameEntity: String) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: nameEntity)
        do {
            try context.fetch(request).forEach {context.delete($0 as! NSManagedObject)}
            saveContext()
        } catch {print(error.localizedDescription)}
    }
    
    private func getContext() -> NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    private func setPropertyForObject(_ object: NSManagedObject, _ dictionaryProperty: [String: Any]) {
        dictionaryProperty.forEach {
            if object.responds(to: NSSelectorFromString($0.key)){
                object.setValue($0.value, forKey: $0.key)
            }
        }
        saveContext()
    }
}
