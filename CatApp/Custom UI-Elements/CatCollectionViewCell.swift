import UIKit

class CatCollectionViewCell: UICollectionViewCell {
    var task: URLSessionDataTask?

    static let reuseIdentifier = "Cat Cell"

    // Индикатор загрузки изображения
    let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        return activityIndicatorView
    }()

    private func activityIndicatorViewConstraints() {
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            activityIndicatorView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier:  0.95),
            activityIndicatorView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier:  0.95)
        ])
    }

    // Рамка для ячейки
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
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.95),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.95)
        ])
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.layer.insertSublayer(gradientLayer, at: 0)
        contentView.clipsToBounds = true

        contentView.addSubview(imageView)
        imageViewConstraints()

        contentView.addSubview(activityIndicatorView)
        activityIndicatorViewConstraints()

        activityIndicatorView.startAnimating()
        addShadow()


    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = bounds.height / 8
        imageView.layer.cornerRadius = bounds.height / 8
        gradientLayer.frame = bounds
    }

    // Метод ответственный за установку тени для ячейки
    private func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.height / 8).cgPath
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 2.0
    }
}
