import CoreData

protocol CoreDataManagerProtocol {
    var persistentContainer: NSPersistentContainer { get }
    func getFetchResultsController(entityName: String, sortDescriptorKey: String, filterKey: String?) -> NSFetchedResultsController<NSFetchRequestResult>
    func getCatObject(with identifier: String) -> CatEntity?
    func saveCat(_ cat: Cat)
    func removeCat(_ cat: Cat)
}

// CoreDataManager - класс ответственный за работу с фреймворком CoreData
class CoreDataManager: CoreDataManagerProtocol {
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CatApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // Метод ответственный за получение NSFetchedResultsController
    func getFetchResultsController(entityName: String, sortDescriptorKey: String, filterKey: String?) -> NSFetchedResultsController<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let sortDescriptor = NSSortDescriptor(key: sortDescriptorKey, ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let filter = filterKey {
            fetchRequest.predicate = NSPredicate(format: "identifier = %@", filter)
        }
        let fetchedResultsVc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)

        return fetchedResultsVc
    }

    // Метод ответственный за получение объекта котика из БД по его идентификатору
    func getCatObject(with identifier: String) -> CatEntity? {
        let fetchRequest: NSFetchRequest<CatEntity> = CatEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "identifier == %@", String(identifier))

        return try? persistentContainer.viewContext.fetch(fetchRequest).first
    }


    // Метод ответственный за сохранение информации о котике в CoreData
    func saveCat(_ cat: Cat) {
        let catObject = CatEntity.object(cat: cat)
        saveContext()
    }

    // Метод ответственный за удаление информации о котике в CoreData
    func removeCat(_ cat: Cat) {
        guard let catObject = getCatObject(with: cat.identifier) else {
            return
        }
        persistentContainer.viewContext.delete(catObject)
        saveContext()
    }


    // Сохранение контекста
    private func saveContext () {
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
