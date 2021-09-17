import UIKit

//  CatListView - класс хранит в себе все UI-элементы MVP-модуля "Детализация котика"
final class CatDetailsView: UIView {

    // Фон
    let background: UIImageView = {
        let background = UIImageView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.image = Image.backgroundDetails
        return background
    }()

    func backgroundConstraints() {
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: topAnchor),
            background.rightAnchor.constraint(equalTo: rightAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor),
            background.leftAnchor.constraint(equalTo: leftAnchor)
        ])
    }

    // Заголовок "Кс-кс-кс! Мур. Мяу."
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = Color.black
        titleLabel.text = "Кс-кс-кс! Мур. Мяу."
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height * 0.03)
        return titleLabel
    }()

    private func titleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: UIScreen.main.bounds.height / 18)
        ])
    }

    // Рамка для изображения котика
    private let imageViewContainer: UIView = {
        let imageViewContainer = UIView()
        imageViewContainer.translatesAutoresizingMaskIntoConstraints = false

        return imageViewContainer
    }()

    private func imageViewContainerConstraints() {
        NSLayoutConstraint.activate([
            imageViewContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageViewContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UIScreen.main.bounds.height / 24),
            imageViewContainer.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            imageViewContainer.heightAnchor.constraint(equalTo: imageViewContainer.widthAnchor)
        ])
    }

    // Градиентный слой для рамки
    private let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [Color.pink.cgColor, Color.blue.cgColor]

        return gradientLayer
    }()

    // Изображение котика
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        return imageView
    }()

    private func imageViewConstraints() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: imageViewContainer.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: imageViewContainer.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: imageViewContainer.widthAnchor, multiplier: 0.95),
            imageView.heightAnchor.constraint(equalTo: imageViewContainer.heightAnchor, multiplier: 0.95)
        ])
    }

    // Кнопка добавления или удаления котика из коллекции
     let actionView: UIView = {
        let actionView = UIView()
        actionView.translatesAutoresizingMaskIntoConstraints = false
        actionView.backgroundColor = .white

        return actionView
    }()

    private func actionViewConstraints() {
        NSLayoutConstraint.activate([
            actionView.rightAnchor.constraint(equalTo: imageViewContainer.rightAnchor),
            actionView.bottomAnchor.constraint(equalTo: imageViewContainer.bottomAnchor),
            actionView.widthAnchor.constraint(equalTo: imageViewContainer.widthAnchor, multiplier: 0.25),
            actionView.heightAnchor.constraint(equalTo: actionView.widthAnchor, multiplier: 0.7)
        ])
    }

    // Иконка кнопки
     let actionImageView: UIImageView = {
        let actionImageView = UIImageView()
        actionImageView.translatesAutoresizingMaskIntoConstraints = false
        actionImageView.contentMode = .scaleAspectFit
        actionImageView.image = Image.saveIcon

        return actionImageView
    }()

    private func actionImageViewConstraints() {
        NSLayoutConstraint.activate([
            actionImageView.centerXAnchor.constraint(equalTo: actionView.centerXAnchor),
            actionImageView.centerYAnchor.constraint(equalTo: actionView.centerYAnchor),
            actionImageView.heightAnchor.constraint(equalTo: actionView.heightAnchor, multiplier: 0.7),
            actionImageView.widthAnchor.constraint(equalTo: actionImageView.heightAnchor)

        ])
    }

    let saveImageToAlbumButton: UIGradientButton = {
        let saveImageToAlbumButton = UIGradientButton()
        saveImageToAlbumButton.translatesAutoresizingMaskIntoConstraints = false
        saveImageToAlbumButton.gradientColors = [Color.pink.cgColor, Color.blue.cgColor]
        saveImageToAlbumButton.setTitleColor(.white, for: .normal)
        saveImageToAlbumButton.setTitle("Сохранить в галерею", for: .normal)
        saveImageToAlbumButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height * 0.02)

        return saveImageToAlbumButton
    }()

    private func saveImageToAlbumButtonConstraints() {
        NSLayoutConstraint.activate([
            saveImageToAlbumButton.topAnchor.constraint(equalTo: imageViewContainer.bottomAnchor, constant: UIScreen.main.bounds.height / 33),
            saveImageToAlbumButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            saveImageToAlbumButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.55),
            saveImageToAlbumButton.heightAnchor.constraint(equalTo: saveImageToAlbumButton.widthAnchor, multiplier: 0.2)
        ])
    }

    let saveImageToDownloadsButton: UIGradientButton = {
        let saveImageToDownloadsButton = UIGradientButton()
        saveImageToDownloadsButton.translatesAutoresizingMaskIntoConstraints = false
        saveImageToDownloadsButton.gradientColors = [Color.pink.cgColor, Color.blue.cgColor]
        saveImageToDownloadsButton.setTitleColor(.white, for: .normal)
        saveImageToDownloadsButton.setTitle("Сохранить в загрузки", for: .normal)
        saveImageToDownloadsButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height * 0.02)

        return saveImageToDownloadsButton
    }()

    private func saveImageToDownloadsButtonConstraints() {
        NSLayoutConstraint.activate([
            saveImageToDownloadsButton.topAnchor.constraint(equalTo: saveImageToAlbumButton.bottomAnchor, constant: UIScreen.main.bounds.height / 33),
            saveImageToDownloadsButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            saveImageToDownloadsButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.55),
            saveImageToDownloadsButton.heightAnchor.constraint(equalTo: saveImageToDownloadsButton.widthAnchor, multiplier: 0.2)
        ])
    }

    // Всплывающее окно с информацией
    let informationView: UIInformationView = {
        let informationView = UIInformationView()
        
        return informationView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        addSubview(background)
        backgroundConstraints()

        addSubview(titleLabel)
        titleLabelConstraints()

        addSubview(imageViewContainer)
        imageViewContainerConstraints()

        imageViewContainer.layer.insertSublayer(gradientLayer, at: 0)

        imageViewContainer.addSubview(imageView)
        imageViewConstraints()

        imageViewContainer.addSubview(actionView)
        actionViewConstraints()

        actionView.addSubview(actionImageView)
        actionImageViewConstraints()

        addSubview(saveImageToAlbumButton)
        saveImageToAlbumButtonConstraints()

        addSubview(saveImageToDownloadsButton)
        saveImageToDownloadsButtonConstraints()

        addSubview(informationView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        gradientLayer.frame = imageViewContainer.bounds
        gradientLayer.cornerRadius = imageViewContainer.bounds.height / 8
        imageViewContainer.layer.cornerRadius = imageViewContainer.bounds.height / 8

        imageViewContainer.layer.shadowColor = UIColor.black.cgColor

        imageViewContainer.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        imageViewContainer.layer.shadowOpacity = 0.25
        imageViewContainer.layer.shadowRadius = 1.0

        imageView.layer.cornerRadius = imageView.bounds.height / 8
        actionView.layer.cornerRadius = imageView.bounds.height / 10
        actionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]

        actionView.layer.shadowColor = UIColor.black.cgColor

        actionView.layer.shadowOffset = CGSize(width: 0.0, height: -1.0)
        actionView.layer.shadowOpacity = 0.25
        actionView.layer.shadowRadius = 1.0
    }
}
