import Foundation

protocol NetworkManagerProtocol {
    func fetchCats(urlString: String, completion: @escaping ([Cat]?) -> Void)
    func fetchImage(urlString: String, checkTask: Bool, completion: @escaping (Data?) -> Void)
}

// NetworkManager - класс ответственный за работу с сетевыми запросами
class NetworkManager: NetworkManagerProtocol {

    // Ключ для доступа к API ...
    private let apiKey = "fb107a77-abdf-4b61-bd27-b2ef810e5bea"

    private let cacheManager: CacheManagerProtocol = CacheManager()
    private var taskDictionary = [String: URLSessionDataTask]()

    // Метод ответственный за построение запроса данных по URL
    private func request(urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)

        task.resume()
    }

    // Метод ответственный за создание DataTask
    private func createDataTask(from requst: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: requst, completionHandler: { (data, _, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        })
    }

    // Метод ответственный за получение данных из сети в формате Data
    private func fetchData(urlString: String, completion: @escaping (Data?) -> Void) {
        request(urlString: urlString) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
            }

            completion(data)
        }
    }

    // Получение данных в JSON формате и преобразование их в любую модель данных через универсальный шаблон
    private func fetchJSONData<T: Decodable>(urlString: String, response: @escaping (T?) -> Void) {
        request(urlString: urlString) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }

            let decoded = self.decodeJSON(type: T.self, from: data)
            response(decoded)

        }
    }

    // Парсинг данных (Data) в любую модель данных через универсальный шаблоны
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        do {
            let objects = try decoder.decode(type.self, from: data)

            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }

    // Получения страницы с персонажами вселенной мультсериала "Рик и Морти"
    func fetchCats(urlString: String, completion: @escaping ([Cat]?) -> Void) {
        fetchJSONData(urlString: urlString, response: completion)
    }

    // Получение изображения из кэша или сети Интернет по URL
    func fetchImage(urlString: String, checkTask: Bool, completion: @escaping (Data?) -> Void) {

        guard let imageData = cacheManager.getImageData(with: urlString) else {
            if checkTask {
                if let task = taskDictionary[urlString] {
                    task.cancel()
                }

                guard let url = URL(string: urlString) else { return }
                let request = URLRequest(url: url)

                taskDictionary[urlString] = createDataTask(from: request) { [weak self] imageData, error in
                    self?.cacheManager.setImageData(imageData ?? Data(), with: urlString)
                    completion(imageData)

                }

                taskDictionary[urlString]?.resume()

            } else {
                fetchData(urlString: urlString) { [weak self] imageData in
                    self?.cacheManager.setImageData(imageData ?? Data(), with: urlString)
                    completion(imageData)

                }
            }
            return
        }

        completion(imageData)
    }
}
