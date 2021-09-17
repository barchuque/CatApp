import UIKit

protocol ModuleBuilderProtocol {
    func buildCatListModule(moduleRouter: ModuleRouterProtocol, networkManager: NetworkManagerProtocol) -> UIViewController
    func buildCatCollectionModule(moduleRouter: ModuleRouterProtocol, networkManager: NetworkManagerProtocol, coreDataManager: CoreDataManagerProtocol) -> UIViewController
    func buildCatDetailsModule(moduleRouter: ModuleRouterProtocol, networkManager: NetworkManagerProtocol, coreDataManager: CoreDataManagerProtocol, saveManager: SaveManagerProtocol, cat: Cat) -> UIViewController
}

// ModuleBuilder - класс ответственный за сборку MVP-модулей
class ModuleBuilder: ModuleBuilderProtocol {

    // Сборка и настройка MVP-модуля "Список котиков"
    func buildCatListModule(moduleRouter: ModuleRouterProtocol, networkManager: NetworkManagerProtocol) -> UIViewController {
        let view = CatListController()
        view.tabBarItem.image = Image.catListIcon
        view.tabBarItem.title = "Котики"

        view.presenter = CatListPresenter(view: view, moduleRouter: moduleRouter, networkManager: networkManager)

        return view
    }

    // Сборка и настройка MVP-модуля "Список избранных котиков"
    func buildCatCollectionModule(moduleRouter: ModuleRouterProtocol, networkManager: NetworkManagerProtocol, coreDataManager: CoreDataManagerProtocol) -> UIViewController {
        let view = CatCollectionController()
        view.tabBarItem.image = Image.catCollectionIcon
        view.tabBarItem.title = "Избранное"

        view.presenter = CatCollectionPresenter(view: view, moduleRouter: moduleRouter, networkManager: networkManager, coreDataManager: coreDataManager)

        return view
    }

    // Сборка и настройка MVP-модуля "Детализация котика"
    func buildCatDetailsModule(moduleRouter: ModuleRouterProtocol, networkManager: NetworkManagerProtocol, coreDataManager: CoreDataManagerProtocol, saveManager: SaveManagerProtocol, cat: Cat) -> UIViewController {
        let view = CatDetailsController()

        view.presenter = CatDetailsPresenter(view: view, moduleRouter: moduleRouter, networkManager: networkManager, coreDataManager: coreDataManager, saveManager: saveManager, cat: cat)

        return view
    }

}
