import Foundation

protocol CacheManagerProtocol {
    func getImageData(with path: String) -> Data?
    func setImageData(_ imageData: Data, with path: String)
}

// CacheManager - класс ответственный за работу с кэшем
class CacheManager: CacheManagerProtocol {
    lazy private var imageCache = NSCache<AnyObject, AnyObject>()

    // Метод ответственный за получение изображения в формате Data из NSCache
    func getImageData(with path: String) -> Data? {
        return imageCache.object(forKey: path as AnyObject) as? Data
    }

    // Метод ответственный за запись изображения в формате Data в NSCache
    func setImageData(_ imageData: Data, with path: String) {
        imageCache.setObject(imageData as AnyObject, forKey: path as AnyObject)
    }
}
