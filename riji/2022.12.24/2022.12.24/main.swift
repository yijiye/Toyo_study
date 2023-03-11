//
//  main.swift
//  2022.12.24
//
//  Created by jiye Yi on 2022/12/24.
//

import Foundation

var budget: Int = 2000
var productList: [String?] = ["볼펜", "텀블러", "다이어리", "에코백", "머그컵", "후드집업"]
var leftProductList: [String] = []
var isOutOfBudget: Bool = false
for index in 0..<productList.count {
    if let product = productList[index] {
        print("\(index)번 상품은 \(product)입니다.")
    }
}

enum PurchasementError: Error {
    case invalidProductIndexError
    case outOfStockError
    case outOfBudgetError
}

func buy(productNumber: Int) -> Result<[String]?, PurchasementError> {
    
    if budget < 1000 {
        return .failure(PurchasementError.outOfBudgetError)
    }
    if productList[productNumber] == nil {
        return .failure(PurchasementError.outOfStockError)
    }
    if productNumber > productList.count {
        return .failure(PurchasementError.invalidProductIndexError)
    }
    budget -= 1000
    productList[productNumber] = nil
    leftProductList = productList.compactMap{ $0 }
    return .success(leftProductList)
}

func buyProduct() {
    print("원하는 상품을 입력해주세요.")
    let input : String? = readLine()
    guard let inputValue = input, let inputProductNumber = Int(inputValue) else {
        return
    }
    let checkCondition = buy(productNumber: inputProductNumber)
    switch checkCondition {
    case .success(_):
        print("\(inputProductNumber)번 상품을 구입하였습니다!")
    case .failure(let error):
        switch error {
        case .invalidProductIndexError:
            print("상품 번호가 잘못되었습니다.")
        case .outOfStockError:
            print("상품의 재고가 없습니다.")
        case .outOfBudgetError:
            print("잔액이 부족합니다.")
            return isOutOfBudget = true
        }
    }
}

while !isOutOfBudget {
    buyProduct()
}

// Result 구문으로 오류처리

enum PurchaseError: Error {
    case outOfStockError
    case outOfBudget
    case invalidProductNumber
}

func purchase(productNumber: Int) -> Result<[String], PurchaseError> {
    if productList[productNumber] == nil {
        return .failure(PurchaseError.outOfStockError)
    }
    if productNumber > productList.count {
        return .failure(PurchaseError.invalidProductNumber)
    }
    if budget < 1000 {
        return .failure(PurchaseError.outOfBudget)
    }
    budget -= 1000
    productList[productNumber] = nil
    let leftProduct = productList.compactMap{ $0 }
    return .success(leftProduct)
}

func purchaseProduct(number: Int) {
    let checkProduct = purchase(productNumber: number)
    switch checkProduct {
    case .success(_):
        print("\(number)번째 상품을 구매했습니다.")
    case .failure(let error):
        switch error {
        case PurchaseError.outOfStockError:
            print("재고가 없습니다")
        case PurchaseError.outOfBudget:
            print("돈이 부족합니다")
        case PurchaseError.invalidProductNumber:
            print("상품번호가 잘못되었습니다")
        }
    }
}

// do-catch 구문

func buyItem(productNumber: Int) throws {
    if productList[productNumber] == nil {
        throw PurchaseError.outOfStockError
    }
    if productNumber > productList.count {
        throw PurchaseError.invalidProductNumber
    }
    if budget < 1000 {
        throw PurchaseError.outOfBudget
    }
    if let product = productList[productNumber] {
        print("구매한 상품은 \(product)입니다")
    }
    budget -= 1000
    productList[productNumber] = nil
}

func purchaseItem(number: Int) {
    do {
        try buyItem(productNumber: number)
    } catch PurchaseError.outOfStockError {
        print("상품 재고가 없습니다.")
    } catch PurchaseError.outOfBudget {
        print("돈이 부족합니다.")
    } catch PurchaseError.invalidProductNumber {
        print("잘못된 상품번호 입니다.")
    } catch {
        print(error)
    }
}

