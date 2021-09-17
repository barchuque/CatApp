import UIKit

protocol CatListPresenterProtocol: AnyObject {
    var countOfCats: Int { get }
    func fetchCats()
    func fetchImage(with index: Int, completion: @escaping (Data?) -> Void)
    func toCatDetail(with index: Int)
}

//  Класс CatListPresenter хранит в себе всю бизнес-логику MVP-модуля "Список котиков"
final class CatListPresenter: CatListPresenterProtocol {
    private let apiURL = "https://api.thecatapi.com/v1/images/search?limit=20"
    
    private weak var view: CatListViewProtocol!
    private let moduleRouter: ModuleRouterProtocol
    private let networkManager: NetworkManagerProtocol

    // Массив котиков
    private var cats = [Cat]() {
        didSet {
            view.updateCatCollection()
        }
    }

    // Вычисляемое свойство для получения текущего количества котиков
    var countOfCats: Int {
        return cats.count
    }

    private var isPaginating = false

    init(view: CatListViewProtocol, moduleRouter: ModuleRouterProtocol, networkManager: NetworkManagerProtocol) {
        self.view = view
        self.moduleRouter = moduleRouter
        self.networkManager = networkManager

        fetchCats()
    }

    // Метод ответственный за загрузку котиков из API
    func fetchCats() {
        guard !isPaginating else { return }

        isPaginating = true

        networkManager.fetchCats(urlString: apiURL) { cats in
            guard let cats = cats else { return }
            self.cats += cats
            self.isPaginating = false
        }
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
