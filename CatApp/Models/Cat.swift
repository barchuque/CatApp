import Foundation

// Cat - структура ответственная за хранение информации о котике
struct Cat: Codable {
    let identifier: String
    let imageURL: String


    // Сопоставление свойств структуры Cat и JSON-ключей в API
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case imageURL = "url"
    }

    // Инициализация структуры из NSManagedObject
    init(catObject: CatEntity) {
        self.identifier = catObject.identifier ?? ""
        self.imageURL = catObject.imageURL ?? ""
    }
}
