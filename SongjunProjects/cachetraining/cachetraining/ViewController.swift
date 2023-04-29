//
//  ViewController.swift
//  cachetraining
//
//  Created by kimseongjun on 2023/04/08.
//

import UIKit

class ViewController: UIViewController {
    
    let provider = Provider()
    
    lazy var imageView1: UIImageView = {
        let imageView1 = UIImageView()
        return imageView1
    }()
    
    lazy var button1: UIButton = {
        let button1 = UIButton()
        button1.setTitle("첫 번째 이미지 받아오기", for: .normal)
        button1.addTarget(self, action: #selector(loadFirstImage), for: .touchUpInside)
        return button1
    }()
    
    @objc
    func loadFirstImage() {
        provider.loadImage1 { [weak self] data in
            DispatchQueue.main.async {
                self?.imageView1.image = UIImage(data: data)
            }
        }
    }
    
    lazy var imageView2: UIImageView = {
        let imageView2 = UIImageView()
        return imageView2
    }()
    
    lazy var button2: UIButton = {
        let button2 = UIButton()
        button2.setTitle("두 번째 이미지 받아오기", for: .normal)
        button2.addTarget(self, action: #selector(loadSecondImage), for: .touchUpInside)
        return button2
    }()
    
    @objc
    func loadSecondImage() {
        
        provider.loadImage2 { [weak self] data in
            DispatchQueue.main.async {
                self?.imageView2.image = UIImage(data: data)
            }
        }
    }
    
    lazy var initializeButton: UIButton = {
        let button = UIButton()
        button.setTitle("이미지 초기화", for: .normal)
        button.addTarget(self, action: #selector(initialImage), for: .touchUpInside)
        return button
    }()
    
    @objc
    func initialImage() {
        imageView1.image = nil
        imageView2.image = nil
    }
    
    lazy var emptButton: UIButton = {
        let button = UIButton()
        button.setTitle("캐시 비우기", for: .normal)
        button.addTarget(self, action: #selector(emptCache), for: .touchUpInside)
        return button
    }()
    
    @objc
    func emptCache() {
        URLCache.shared.removeAllCachedResponses()
    }
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.backgroundColor = .gray
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        imageView1.translatesAutoresizingMaskIntoConstraints = false
        button1.translatesAutoresizingMaskIntoConstraints = false
        imageView2.translatesAutoresizingMaskIntoConstraints = false
        button2.translatesAutoresizingMaskIntoConstraints = false
        initializeButton.translatesAutoresizingMaskIntoConstraints = false
        emptButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(imageView1)
        stackView.addArrangedSubview(button1)
        stackView.addArrangedSubview(imageView2)
        stackView.addArrangedSubview(button2)
        stackView.addArrangedSubview(initializeButton)
        stackView.addArrangedSubview(emptButton)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            imageView1.heightAnchor.constraint(equalToConstant: 200),
            imageView1.widthAnchor.constraint(equalToConstant: 200),
            
            imageView2.heightAnchor.constraint(equalToConstant: 200),
            imageView2.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}

class Provider {
    func loadImage1(completion: @escaping (Data) -> Void) {
        
        guard let url1 = URL(string: "https://wallpaperaccess.com/download/europe-4k-1369012") else { return }
        
        var urlRequest = URLRequest(url: url1)
        urlRequest.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else { return }
            
            guard let httpURLResponse = response as? HTTPURLResponse, (200...299).contains(httpURLResponse.statusCode) else { return }
            
            guard let validData = data else { return }
            
            let cachedURLResponse = CachedURLResponse(response: httpURLResponse, data: validData, storagePolicy: .allowed)
            
            URLCache.shared.storeCachedResponse(cachedURLResponse, for: urlRequest)
            
            completion(validData)
        }
        
        URLCache.shared.getCachedResponse(for: dataTask) { cachedResponse in
            if let cachedResponse = cachedResponse {
                print("캐시된 이미지 로드")
                completion(cachedResponse.data)
            }
            else {
                print("서버 이미지 로드")
                dataTask.resume()
            }
        }
    }
    
    func loadImage2(completion: @escaping (Data) -> Void) {
        
        guard let url1 = URL(string: "https://wallpaperaccess.com/download/europe-4k-1318341") else { return }
        
        var urlRequest = URLRequest(url: url1)
        urlRequest.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else { return }
            
            guard let httpURLResponse = response as? HTTPURLResponse, (200...299).contains(httpURLResponse.statusCode) else { return }
            
            guard let validData = data else { return }
            
            let cachedURLResponse = CachedURLResponse(response: httpURLResponse, data: validData, storagePolicy: .allowed)
            
            URLCache.shared.storeCachedResponse(cachedURLResponse, for: urlRequest)
            
            completion(validData)
        }
        
        
        URLCache.shared.getCachedResponse(for: dataTask) { cachedResponse in
            if let cachedResponse = cachedResponse {
                print("캐시된 이미지 로드")
                completion(cachedResponse.data)
            }
            else {
                print("서버 이미지 로드")
                dataTask.resume()
            }
        }
    }
}

