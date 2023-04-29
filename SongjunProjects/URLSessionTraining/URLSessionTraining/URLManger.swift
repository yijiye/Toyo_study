//
//  URLManger.swift
//  URLSessionTraining
//
//  Created by kimseongjun on 2023/03/25.
//

import UIKit

struct TextData: Encodable {
    let name: String
    let description: String
    let price: Double
    let currency: Currency
    let discountedPrice: Double
    let stock: Int
    let secret: String
    
    init(name: String, description: String, price: Double, currency: Currency, discountedPrice: Double, stock: Int, secret: String) {
            self.name = name
            self.description = description
            self.price = price
            self.currency = currency
            self.discountedPrice = discountedPrice
            self.stock = stock
            self.secret = secret
        }
    
    enum CodingKeys: String, CodingKey {
        case name, description, price, currency
        case discountedPrice = "discounted_price"
        case stock, secret
    }
}

struct TextData2: Encodable {
    let name: String = "ksdk"
    let description: String = "이 상품으로 말할거 같으면..."
    let price: Double = 12000
    let currency: Currency = Currency.KRW
    let discountedPrice: Double = 14000
    let stock: Int = 50
    let secret: String = "ASDAasd"
    
    enum CodingKeys: String, CodingKey {
        case name, description, price, currency
        case discountedPrice = "discounted_price"
        case stock, secret
    }
}

enum Currency: String, Encodable {
    case KRW
    case USD
}

struct URLManager {
    let textData = TextData2()
    
    
    
    func postAPI() {
        
//        let parameters = try! JSONEncoder().encode(textData)
        let parameters = [ "name": "ttt", "description": "t1t1t1", "price": 10000, "currency":  "KRW", "discounted_price":  500, "stock":  1234567, "secret": "soobak1234" ] as [String : Any]
            
            
        guard let url = URL(string: "https://openmarket.yagom-academy.kr/api/products?page_no=1&items_per_page=100") else { return }
        
        var images = [UIImage]()
        images.append(UIImage(named: "image")!)
        
    
        
        let boundary = "Boundary-\(UUID().uuidString)"

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary\(boundary)",
                forHTTPHeaderField: "Content-Type")
        
        var data = Data()
        print(images)
        
        for image in images {
            data.append("--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"file\"\r\n".data(using: .utf8)!)
            data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
            data.append(image.pngData()!)
            data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        }
        
        request.httpBody = data
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                return
            }
                        
            guard let data = data else {
                print("No data")
                return
            }
            print(String(data: data, encoding: .utf8)!)

            
        }
        task.resume()
    }
    
}
