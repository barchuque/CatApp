import Foundation
import CoreData

@objc(CatEntity)
public class CatEntity: NSManagedObject {
    
    // Метод ответственный за получение NSManagedObject из структуры Cat
    static func object(cat: Cat) -> CatEntity {
        let coreDataManager: CoreDataManagerProtocol = AppDelegate.coreDataManager
        
        let entityDescription = NSEntityDescription.entity(forEntityName: String(describing: CatEntity.self), in: coreDataManager.persistentContainer.viewContext)!

        let catObject = CatEntity(entity: entityDescription, insertInto: coreDataManager.persistentContainer.viewContext)

        catObject.identifier = cat.identifier
        catObject.imageURL = cat.imageURL

        return catObject
    }
}
