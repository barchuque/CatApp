import UIKit

protocol CatDetailsPresenterProtocol: AnyObject {
    func actionWithCat()
    func saveImageToAlbum()
    func saveImageToDownloads()
}

//  Класс CatDetailsPresenter хранит в себе всю бизнес-логику MVP-модуля "Детализация котика"
final class CatDetailsPresenter: CatDetailsPresenterProtocol {
    private weak var view: CatDetailsViewProtocol!
    private let moduleRouter: ModuleRouterProtocol
    private let networkManager: NetworkManagerProtocol
    private let coreDataManager: CoreDataManagerProtocol
    private let saveManager: SaveManagerProtocol

    private let cat: Cat

    var isSaved: Bool {
        return coreDataManager.getCatObject(with: cat.identifier) != nil
    }

    init(view: CatDetailsViewProtocol, moduleRouter: ModuleRouterProtocol, networkManager: NetworkManagerProtocol, coreDataManager: CoreDataManagerProtocol, saveManager: SaveManagerProtocol, cat: Cat) {
        self.view = view
        self.moduleRouter = moduleRouter
        self.networkManager = networkManager
        self.coreDataManager = coreDataManager
        self.saveManager = saveManager
        self.cat = cat

        fetchImage()
        view.setSaved(isSaved)
    }

    // Получение изображения котика
    private func fetchImage() {
        networkManager.fetchImage(urlString: cat.imageURL, checkTask: false) { [weak self] imageData in
            guard let imageData = imageData else { return }

            self?.view.setImageData(imageData)

        }
    }

    // Добавление / удаление котика из коллекции
    func actionWithCat() {
        if isSaved {
            coreDataManager.removeCat(cat)
            view.setSaved(false)
            view.showInformation(title: "Кшшшшшшш!", text: "Котик зол! Вы удалили его из своей коллекции.")

        } else {
            coreDataManager.saveCat(cat)
            view.setSaved(true)
            view.showInformation(title: "Мур!", text: "Вы успешно добавили этого милого котика в свою коллекцию.")
        }
    }

    // Сохранение изображения котика в галерею
    func saveImageToAlbum() {
        networkManager.fetchImage(urlString: cat.imageURL, checkTask: false) { [weak self] imageData in
            guard let imageData = imageData else {
                self?.view.showInformation(title: "Неудача!", text: "Неудалось сохранить изображение котика в галерею.")
                return
            }

            self?.saveManager.saveImageDataToAlbum(imageData: imageData) { error in
                guard let error = error else {
                    self?.view.showInformation(title: "Мяу!", text: "Вы успешно сохранили котика в свою галерею.")
                    return
                }

                self?.view.showInformation(title: "Неудача!", text: error)

            }
        }
    }

    // Сохранение изображения котика в загрузки
    func saveImageToDownloads() {
        networkManager.fetchImage(urlString: cat.imageURL, checkTask: false) { [weak self] imageData in
            guard let imageData = imageData else {
                self?.view.showInformation(title: "Неудача!", text: "Неудалось сохранить изображение котика в загрузки.")
                return
            }

            self?.saveManager.saveImageDataToDownloads(imageData: imageData) { error in
                guard let error = error else {
                    self?.view.showInformation(title: "Мяу!", text: "Вы успешно сохранили котика в загрузки.")
                    return
                }

                self?.view.showInformation(title: "Неудача!", text: error)

            }
        }
    }
}
