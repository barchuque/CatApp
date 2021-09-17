import UIKit

protocol SaveManagerProtocol {
    func saveImageDataToAlbum(imageData: Data, completion: @escaping (String?) -> Void)
    func saveImageDataToDownloads(imageData: Data, completion: @escaping (String?) -> Void)
}

// SaveManager - класс ответственный за сохранение изображений в память устройства
class SaveManager: NSObject, SaveManagerProtocol {

    private var saveImageDataToAlbumCompletion: ((String?) -> Void)?

    // Метод ответственный за загрузку изображения в галерею устройства
    func saveImageDataToAlbum(imageData: Data, completion: @escaping (String?) -> Void) {
        guard let image = UIImage(data: imageData) else {
            return
        }

        saveImageDataToAlbumCompletion = completion
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.imageWriteToSavedPhotosAlbumCompletion(_:didFinishWithError:contextInfo:)), nil)
    }

    @objc private func imageWriteToSavedPhotosAlbumCompletion(_ image: UIImage, didFinishWithError error: Error?, contextInfo: UnsafeRawPointer) {
        guard let completion = saveImageDataToAlbumCompletion else { return }

        guard error == nil else {
            completion("Неудалось сохранить изображение котика в галерею.")
            return
        }

        completion(nil)
    }

    // Метод ответственный за загрузку изображения в "Загрузки"
    func saveImageDataToDownloads(imageData: Data, completion: @escaping (String?) -> Void) {
        guard let image = UIImage(data: imageData) else {
            completion("Неудалось сохранить изображение котика в загрузки.")
            return
        }

        guard let downloadsDirectory = try? FileManager.default.url(for: .downloadsDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else {
            completion("Неудалось сохранить изображение котика в загрузки.")
            return
        }

        let imageName = UUID().uuidString

        let uploadURL = downloadsDirectory.appendingPathComponent("\(imageName).png", isDirectory: true)

        if !FileManager.default.fileExists(atPath: uploadURL.path) {
            do {
                try image.pngData()?.write(to: uploadURL)
                completion(nil)
            } catch {
                completion("Неудалось сохранить изображение котика в загрузки.")
            }
        }
    }
}
