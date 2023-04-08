## 소스코드

```swift
import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var fetchFirstImageButton: UIButton!
    @IBOutlet weak var secondImgaView: UIImageView!
    @IBOutlet weak var fetchSecondImageButton: UIButton!
    @IBOutlet weak var resetImageButton: UIButton!
    @IBOutlet weak var resetCacheButton: UIButton!
    
    let networkManager = NetworkManager()
    let firstImageURL = "https://wallpaperaccess.com/download/europe-4k-1369012"
    let secondImageURL = "https://wallpaperaccess.com/download/europe-4k-1318341"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func fetchFirstImageButtonTapped(_ sender: UIButton) {
                fetchImage(from: firstImageURL, imageView: firstImageView)
//        downloadImage(from: firstImageURL, imageView: firstImageView)
        
    }
    
    @IBAction func fetchSecondImageButtonTapped(_ sender: UIButton) {
                fetchImage(from: secondImageURL, imageView: secondImgaView)
//        downloadImage(from: secondImageURL, imageView: secondImgaView)
    }
    
    @IBAction func resetImageButtonTapped(_ sender: UIButton) {
        firstImageView.image = nil
        secondImgaView.image = nil
        print("이미지를 초기화합니다.")
    }
    
    @IBAction func resetCachedImageButtonTapped(_ sender: UIButton) {
                ImageCacheManager.shared.remove()
//        URLCache.shared.removeAllCachedResponses()
        print("캐시된 이미지 삭제")
    }
    
    //MARK: NSCache
    private func fetchImage(from imageURL: String, imageView: UIImageView) {
        
        networkManager.loadImage(from: imageURL) { result in
            switch result {
            case .failure(let error):
                print(error.description)
            case .success(let image):
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }
    }
    
    //MARK: URLCache
    private func downloadImage(from imageURL: String, imageView: UIImageView) {
        guard let url = URL(string: imageURL) else { return }
        let request = URLRequest(url: url)
        
        networkManager.loadURLCachedImage(from: request) { result in
            switch result {
            case .failure(let error):
                print(error.description)
            case .success(let data):
                
                DispatchQueue.main.async {
                    let cachedImage = UIImage(data: data)
                    imageView.image = cachedImage
                }
                return
            }
        }
    }
}
```

```swift
import Foundation
import UIKit

struct NetworkManager {
    func loadImage(from imageURL: String, completion: @escaping ((Result<UIImage, NetworkError>) -> Void)) {
        guard let url = URL(string: imageURL) else { return }
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if error != nil {
                completion(.failure(.unknown))
                return
            }
            
            if let data = data {
                guard let result = UIImage(data: data) else {
                    completion(.failure(.decode))
                    return
                }
                
                ImageCacheManager.shared.setObject(image: result, urlString: imageURL)
                print("새로운 이미지를 받아왔습니다.")
                completion(.success(result))
            }
            
        }
        
        if let cachedImage = ImageCacheManager.shared.cachedImage(urlString: imageURL) {
            print("캐시된 이미지 불러오기")
            completion(.success(cachedImage))
        } else {
            task.resume()
        }
    }
    
    func loadURLCachedImage(from imageURL: URLRequest, completion: @escaping ((Result<(Data), NetworkError>) -> Void)) {
        
        // MARK: task 생성
        let task = URLSession.shared.dataTask(with: imageURL) { data, response, error in
            // MARK: task resume이 되면서 실행
            if error != nil {
                completion(.failure(.unknown))
                return
            }
            
            guard response is HTTPURLResponse else {
                completion(.failure(.response))
                return
            }
            
            if let data = data,
               let response = response {
                let cachedResponse = CachedURLResponse(response: response, data: data)
                URLCache.shared.storeCachedResponse(cachedResponse, for: imageURL)
                print("새로 저장")
                completion(.success(data))
            }
        }
        
        // MARK: task 생성 후 실행되는 코드
        URLCache.shared.getCachedResponse(for: task) { cachedResponse in
            if let cachedResponse = cachedResponse {
                print("캐시된 데이터가 있습니다.")
                completion(.success(cachedResponse.data))
            } else {
                task.resume()
            }
        }
    }
}

enum NetworkError: LocalizedError {
    case unknown
    case decode
    case response
    
    var description: String {
        switch self{
        case .unknown:
            return "Unknown Error"
        case .decode:
            return "Decode Error"
        case .response:
            return "Response Error"
        }
    }
} 
```

```swift
import UIKit

final class ImageCacheManager {
    static let shared = ImageCacheManager()
    private init() {}
    
    private let storage = NSCache<NSString, UIImage>()
    
    func cachedImage(urlString: String) -> UIImage? {
        let cachedKey = NSString(string: urlString)
        if let cachedImage = storage.object(forKey: cachedKey) {
            return cachedImage
        }
        return nil
    }
    
    func setObject(image: UIImage, urlString: String) {
        let forKey = NSString(string: urlString)
        storage.setObject(image, forKey: forKey)
    }
    
    func remove() {
        storage.removeAllObjects()
    }
}
```

