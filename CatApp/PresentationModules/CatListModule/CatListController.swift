import UIKit

protocol CatListViewProtocol: AnyObject {
    func updateCatCollection()
}

//  Класс CatListController хранит в себе всю логику работы с View MVP-модуля "Список котиков"
final class CatListController: UIViewController, CatListViewProtocol {
    var presenter: CatListPresenterProtocol?

    override func loadView() {
        view = CatListView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = self.view as? CatListView

        view?.catCollectionView.dataSource = self
        view?.catCollectionView.delegate = self
    }

    // Метод ответственный за обновление коллекции котиков
    func updateCatCollection() {
        let view = self.view as? CatListView
        view?.catCollectionView.reloadData()
    }
}

extension CatListController: UICollectionViewDataSource, UICollectionViewDelegate {
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

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let view = self.view as? CatListView else { return }

        let position = scrollView.contentOffset.y
        if position > (view.catCollectionView.contentSize.height - 100 - scrollView.frame.size.height) {
            presenter?.fetchCats()
        }
    }

}
