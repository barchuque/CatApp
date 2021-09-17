import UIKit

// UIGradientLbel - UILabel с градиентом
class UIGradientLabel: UIView {
    
    // Вычисляемое свойство, позволяющее установить или получить текущий текст
    var text: String {
        get {
            return label.text ?? ""
        }
        set {
            label.text = newValue
        }
    }

    // Вычисляемое свойство, позволяющее установить или получить текущий UIFont
    var font: UIFont? {
        get {
            return label.font
        }
        set {
            label.font = newValue
        }
    }

    // Вычисляемое свойство, позволяющее установить или получить текущие цвета градиента
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
        let gradient = CAGradientLayer()

        gradient.colors = [
            UIColor.black.cgColor
        ]

        return gradient
    }()

    // UILabel, к которому применяется градиент
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ITinder"
        label.textColor = .black

        return label
    }()

    private func labelConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.rightAnchor.constraint(equalTo: rightAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.leftAnchor.constraint(equalTo: leftAnchor)
        ])
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.addSublayer(gradientLayer)

        addSubview(label)
        labelConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()

        gradientLayer.frame = bounds
        mask = label
    }

    // Метод ответственный за установку тени для надписи
    func addShadow() {
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 2
        label.layer.shadowOpacity = 0.25
        label.layer.shadowOffset = CGSize(width: 0, height: 2)
        label.layer.masksToBounds = false
    }
}
