import CoreData

protocol CatCollectionPresenterProtocol: AnyObject {
    var countOfCats: Int { get }
    func fetchImage(with index: Int, completion: @escaping (Data?) -> Void)
    func toCatDetail(with index: Int)
    func setupFetchResultsController()
}

//  Класс CatCollectionPresenter хранит в себе всю бизнес-логику MVP-модуля "Список избранных котиков"
final class CatCollectionPresenter: NSObject, CatCollectionPresenterProtocol {

    private weak var view: CatCollectionViewProtocol!
    private let moduleRouter: ModuleRouterProtocol
    private let coreDataManager: CoreDataManagerProtocol
    private let networkManager: NetworkManagerProtocol

    private var fetchResultsController: NSFetchedResultsController<CatEntity>?

    // Массив котиков
    private var cats: [Cat] = [] {
        didSet {
            view.updateCatCollection()
            view.setPlaceholderVisible(cats.isEmpty)
        }
    }

    // Вычисляемое свойство для получения текущего количества котиков
    var countOfCats: Int {
        return cats.count
    }

    init(view: CatCollectionViewProtocol, moduleRouter: ModuleRouterProtocol, networkManager: NetworkManagerProtocol, coreDataManager: CoreDataManagerProtocol) {
        self.view = view
        self.moduleRouter = moduleRouter
        self.networkManager = networkManager
        self.coreDataManager = coreDataManager
    }

    func setupFetchResultsController() {
        fetchResultsController = coreDataManager.getFetchResultsController(entityName: String(describing: CatEntity.self), sortDescriptorKey: "identifier", filterKey: nil) as? NSFetchedResultsController<CatEntity>
        fetchResultsController?.delegate = self
         try? fetchResultsController?.performFetch()
         cats = fetchResultsController?.fetchedObjects?.map { catObject in
            return Cat(catObject: catObject)
         } ?? []
     }

    // Метод-обертка для получения изображения котика
    func fetchImage(with index: Int, completion: @escaping (Data?) -> Void) {
        networkManager.fetchImage(urlString: cats[index].imageURL, checkTask: true, completion: completion)
    }

    // Метод ответсвенный за переход к MVP-модулю "Детализация котика"
    func toCatDetail(with index: Int) {
        moduleRouter.toCatDetailModule(cat: cats[index])
    }
    
}

extension CatCollectionPresenter: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        cats = fetchResultsController?.fetchedObjects?.map { catObject in
                return Cat(catObject: catObject)
        } ?? []
    }
}
