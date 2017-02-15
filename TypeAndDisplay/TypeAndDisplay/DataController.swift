import UIKit
import CoreData

class DataController: NSObject{
    var managedObjectContext: NSManagedObjectContext
    var usersFromCoreData: [NSManagedObject] {
        get {
            
            var resultArray:Array<NSManagedObject>!
            let managedContext = self.managedObjectContext
            let fetchRequest =
                NSFetchRequest<NSManagedObject>(entityName: "User")
            
            do {
                resultArray = try managedContext.fetch(fetchRequest)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
            
            return resultArray
        }
    }
    
    override  init() {
        guard let modelURL = Bundle.main.url(forResource:
            "Model", withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }

        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        self.managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        self.managedObjectContext.persistentStoreCoordinator = psc
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docURL = urls[urls.endIndex-1]

        let storeURL = docURL.appendingPathComponent("Model.sqlite")
        do {
            try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
        } catch {
            fatalError("Error migrating store: \(error)")
        }
        
    }
    func deleteObject(obj: NSManagedObject, complition:(_ result: Bool)->Void){
        
        self.managedObjectContext.delete(obj)
        
        do{
            try self.managedObjectContext.save()
            complition(true)
        }catch{
            complition(false)
        }
    }
    
    func updateObject(complition:(_ result: Bool)->Void){
        do{
            try self.managedObjectContext.save()
            complition(true)
        }catch{
            complition(false)
        }
    }
    
}

