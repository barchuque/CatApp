import UIKit
protocol CatCollectionViewProtocol: AnyObject {
    func updateCatCollection()
    func setPlaceholderVisible(_ isVisible: Bool)
}

//  Класс CatCollectionController хранит в себе всю логику работы с View MVP-модуля "Список избранных котиков"
final class CatCollectionController: UIViewController, CatCollectionViewProtocol {
     var presenter: CatCollectionPresenterProtocol?

    override func loadView() {
        view = CatCollectionView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = self.view as? CatCollectionView

        view?.catCollectionView.dataSource = self
        view?.catCollectionView.delegate = self

        presenter?.setupFetchResultsController()
    }

    // Метод ответственный за обновление коллекции котиков
    func updateCatCollection() {
        let view = self.view as? CatCollectionView
        view?.catCollectionView.reloadData()
    }

    // Метод ответственный за показ / скрытие информации об отсутствии котиков
    func setPlaceholderVisible(_ isVisible: Bool) {
        let view = self.view as? CatCollectionView
        view?.placeholder.isHidden = !isVisible
    }

}

extension CatCollectionController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.countOfCats ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let catCell = collectionView.dequeueReusableCell(withReuseIdentifier: CatCollectionViewCell.reuseIdentifier, for: indexPath)

        if let catCell = catCell as? CatCollectionViewCell {
            catCell.imageView.image = nil
            catCell.activityIndicatorView.startAnimating()
            presenter?.fetchImage(with: indexPath.item) { imageData in
                guard let imageData = imageData else {
                    return
                }
                catCell.activityIndicatorView.stopAnimating()
                catCell.imageView.image = UIImage(data: imageData)
            }
        }
        
        return catCell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.toCatDetail(with: indexPath.item)
    }
}
