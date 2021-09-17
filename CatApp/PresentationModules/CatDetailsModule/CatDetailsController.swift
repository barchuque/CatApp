import UIKit

protocol CatDetailsViewProtocol: AnyObject {
    func setSaved(_ isSaved: Bool)
    func setImageData(_ imageData: Data)
    func showInformation(title: String, text: String)
}

//  Класс CatDetailsController хранит в себе всю логику работы с View MVP-модуля "Детализация котика"
final class CatDetailsController: UIViewController, CatDetailsViewProtocol {
    var presenter: CatDetailsPresenterProtocol?

    override func loadView() {
        view = CatDetailsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = self.view as? CatDetailsView

        let actionGestureTap = UITapGestureRecognizer(target: self, action: #selector(actionViewDidTouched))
        view?.actionView.addGestureRecognizer(actionGestureTap)

        view?.saveImageToAlbumButton.addTarget(self, action: #selector(saveImageToAlbumButtonTouched), for: .touchUpInside)

        view?.saveImageToDownloadsButton.addTarget(self, action: #selector(saveImageToDownloadsButtonTouched), for: .touchUpInside)
    }

    @objc func actionViewDidTouched() {
        presenter?.actionWithCat()
    }

    @objc func saveImageToAlbumButtonTouched() {
        presenter?.saveImageToAlbum()
    }

    @objc func saveImageToDownloadsButtonTouched() {
        presenter?.saveImageToDownloads()
    }

    // Установка изображения котика
    func setImageData(_ imageData: Data) {
        let view = self.view as? CatDetailsView
        view?.imageView.image = UIImage(data: imageData)
    }

    // Установка изображения кнопки добавить / удалить из коллекции
    func setSaved(_ isSaved: Bool) {
        let view = self.view as? CatDetailsView
        view?.actionImageView.image = isSaved ? Image.removeIcon : Image.saveIcon
    }

    // Показ всплывающего окна
    func showInformation(title: String, text: String) {
        let view = self.view as? CatDetailsView
        view?.informationView.show(title: title, text: text)
    }
}
