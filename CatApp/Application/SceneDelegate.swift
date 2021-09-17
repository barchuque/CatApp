import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let moduleBuilder: ModuleBuilderProtocol = ModuleBuilder()
        let tabBarController = UITabBarController()

        let moduleRouter: ModuleRouterProtocol = ModuleRouter(moduleBuilder: moduleBuilder, tabBarController: tabBarController)
        moduleRouter.setupTabBarController()

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}
