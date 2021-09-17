import Foundation
import CoreData

extension CatEntity {

    public class func fetchRequest() -> NSFetchRequest<CatEntity> {
        return NSFetchRequest<CatEntity>(entityName: "CatEntity")
    }

    @NSManaged public var identifier: String?
    @NSManaged public var imageURL: String?

}
