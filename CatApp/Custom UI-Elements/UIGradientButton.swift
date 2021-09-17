import UIKit

// UIGradientButton - UIButton с градиентом
class UIGradientButton: UIButton {

    // Установка / получение цветов градиента
    var gradientColors: [CGColor] {
        get {
            return gradientLayer.colors as? [CGColor] ?? []
        }
        set {
            gradientLayer.colors = newValue
        }
    }

    // Градиентный слой
    private let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()

        gradientLayer.colors = [
            UIColor.black.cgColor
        ]

        return gradientLayer
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.insertSublayer(gradientLayer, at: 0)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Метод ответственный за добавление тени у кнопки
    private func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.height / 2).cgPath
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowOpacity = 0.15
        layer.shadowRadius = 2.0
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()

        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = bounds.height / 2

        addShadow()
    }
}
