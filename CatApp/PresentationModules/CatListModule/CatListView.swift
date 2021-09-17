import UIKit

//  CatListView - класс хранит в себе все UI-элементы MVP-модуля "Список котиков"
final class CatListView: UIView {

    // Фон
    private let background: UIImageView = {
        let background = UIImageView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.image = Image.background
        return background
    }()

    private func backgroundConstraints() {
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: topAnchor),
            background.rightAnchor.constraint(equalTo: rightAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor),
            background.leftAnchor.constraint(equalTo: leftAnchor)
        ])
    }

    // Контейнер для заголовка
    private let titleView: UIView = {
        let titleView = UIView()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.backgroundColor = .white
        titleView.layer.zPosition = 1
        return titleView
    }()

    private func titleViewConstraints() {
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            titleView.widthAnchor.constraint(equalTo: widthAnchor),
            titleView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.12)
        ])
    }

    // Заголовок "Котики со всего мира"
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Котики со всего мира"
        titleLabel.textAlignment = .center
        titleLabel.textColor = Color.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height * 0.03)

        return titleLabel
    }()

    private func titleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor)
        ])
    }

    // UICollectionView для отображения карточек с котиками
    let catCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.41, height: UIScreen.main.bounds.width * 0.41)
        layout.minimumLineSpacing = UIScreen.main.bounds.width * 0.03
        let inset = UIScreen.main.bounds.width * 0.06
        let catCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        catCollectionView.backgroundColor = .none
        catCollectionView.translatesAutoresizingMaskIntoConstraints = false
        catCollectionView.contentInset = UIEdgeInsets(top: (UIScreen.main.bounds.height / 12) + (UIScreen.main.bounds.width * 0.09), left: inset, bottom: inset, right: inset)
        catCollectionView.scrollIndicatorInsets = UIEdgeInsets(top: (UIScreen.main.bounds.height / 12) + (UIScreen.main.bounds.width * 0.09), left: 0, bottom: 0, right: 0)
        catCollectionView.register(CatCollectionViewCell.self, forCellWithReuseIdentifier: CatCollectionViewCell.reuseIdentifier)

        return catCollectionView
    }()

    private func catCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            catCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            catCollectionView.rightAnchor.constraint(equalTo: rightAnchor),
            catCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            catCollectionView.leftAnchor.constraint(equalTo: leftAnchor)
        ])
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        addSubview(background)
        backgroundConstraints()

        addSubview(catCollectionView)
        catCollectionViewConstraints()

        addSubview(titleView)
        titleViewConstraints()

        titleView.addSubview(titleLabel)
        titleLabelConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        titleView.layer.cornerRadius = titleView.bounds.height / 4
        titleView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

        titleViewAddShadow()
    }

    private func titleViewAddShadow() {
        titleView.layer.shadowColor = UIColor.black.cgColor
        titleView.layer.shadowPath = UIBezierPath(roundedRect: titleView.bounds, cornerRadius: titleView.bounds.height / 4).cgPath
        titleView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        titleView.layer.shadowOpacity = 0.25
        titleView.layer.shadowRadius = 1.0
    }
}
