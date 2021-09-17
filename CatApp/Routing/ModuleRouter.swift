import UIKit

protocol ModuleRouterProtocol {
    func setupTabBarController()
    func toCatDetailModule(cat: Cat)
    func dismiss()
}

// ModuleRouter - класс ответственный за навигацию между MVP-модулями
class ModuleRouter: ModuleRouterProtocol {

    private let moduleBuilder: ModuleBuilderProtocol
    private let tabBarController: UITabBarController

    // Объявление менеджеров (в единственном экземляре) для дальнейшей передачи их в MVP-модули
    lazy private var networkManager: NetworkManagerProtocol = NetworkManager()
    lazy private var coreDataManager: CoreDataManagerProtocol = AppDelegate.coreDataManager
    lazy private var saveManager: SaveManagerProtocol = SaveManager()

    init(moduleBuilder: ModuleBuilderProtocol, tabBarController: UITabBarController) {
        self.moduleBuilder = moduleBuilder
        self.tabBarController = tabBarController

        self.tabBarController.tabBar.tintColor = Color.pink
        self.tabBarController.tabBar.unselectedItemTintColor = Color.gray

        self.tabBarController.tabBar.isTranslucent = false
    }

    // Настройка tabBarController
    func setupTabBarController() {
        let catListModule = moduleBuilder.buildCatListModule(moduleRouter: self, networkManager: networkManager)
        let catCollectionModule = moduleBuilder.buildCatCollectionModule(moduleRouter: self, networkManager: networkManager, coreDataManager: coreDataManager)

        tabBarController.setViewControllers([catListModule, catCollectionModule], animated: false)
    }

    // Переход к MVP-модулю "Детализация котика"
    func toCatDetailModule(cat: Cat) {
        let catDetailModule = moduleBuilder.buildCatDetailsModule(moduleRouter: self, networkManager: networkManager, coreDataManager: coreDataManager, saveManager: saveManager, cat: cat)

        tabBarController.present(catDetailModule, animated: true)
    }

    // Скрытие модального окна
    func dismiss() {
        tabBarController.dismiss(animated: true)
    }
}
