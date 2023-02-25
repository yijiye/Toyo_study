//
//  ViewController.swift
//  FoodTable
//
//  Created by Harry on 2023/02/25.
//

import UIKit

enum FoodType: String, CaseIterable {
    case American
    case Chinese
    case Korean
    case Japanese
}

struct Food {
    let name: String
    var price: Int
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var menu: [FoodType: [Food]] = [
        .American: [
            Food(name: "햄버거", price: 5000),
            Food(name: "피자", price: 18000),
            Food(name: "아메리카노", price: 41000)
        ],
        .Chinese: [
            Food(name: "탕수육", price: 18000)
        ],
        .Korean: [
            Food(name: "비빔밥", price: 8000),
            Food(name: "돼지갈비", price: 20000)
        ],
        .Japanese: [
            Food(name: "스시", price: 20000),
            Food(name: "스윙스(돈까스)", price: 5000)
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        configureHeader()
    }
 
    func configureHeader() {
        let header = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 20))
        header.text = "메뉴판"
        header.textAlignment = .center
        header.font = .preferredFont(forTextStyle: .title2)
        header.textColor = .label
        
        tableView.tableHeaderView = header
    }

}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return menu[menu.index(menu.startIndex, offsetBy: section)].key.rawValue
        
//        return menu[section].keys.first?.rawValue
        
        let sectionTitle = FoodType.allCases[section].rawValue
        
        return sectionTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        return menu[menu.index(menu.startIndex, offsetBy: section)].value.count
        
//        return menu[section].values.first!.count
        
        let index = FoodType.allCases[section]
        guard let count = menu[index]?.count else { return 0 }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodEntryCell", for: indexPath) as! FoodEntryCell
        // MARK: - 방법1
//        let foodArray = menu[menu.index(menu.startIndex, offsetBy: indexPath.section)].value
//
//        cell.fooNameLabel.text = foodArray[indexPath.row].name
        // MARK: - 방법2
//        let foodarray = menu[indexPath.section].values.first
//        cell.fooNameLabel.text = foodarray![indexPath.row].name
        // MARK: - 방법3
        let index = FoodType.allCases[indexPath.section]
        guard let dict = menu[index] else { return UITableViewCell() }
        let content = dict[indexPath.row]
        cell.fooNameLabel.text = content.name
        
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
}

