//
//  ViewController.swift
//  menuTableViewTest
//
//  Created by jiye Yi on 2023/02/25.
//

import UIKit

enum FoodType: String, CaseIterable {
    case american = "American"
    case chinese = "Chinese"
    case korean = "Korean"
    case japanese = "Japanese"
}

struct Food {
    let name: String
    var price: Int
}

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var menu: [FoodType: [Food]] = [
        .american: [
            Food(name: "햄버거", price: 5000),
            Food(name: "피자", price: 18000),
            Food(name: "아메리카노", price: 41000)
        ],
        .chinese: [
            Food(name: "탕수육", price: 18000)
        ],
        .korean: [
            Food(name: "비빔밥", price: 8000),
            Food(name: "돼지갈비", price: 20000)
        ],
        .japanese: [
            Food(name: "스시", price: 20000),
            Food(name: "스윙스(돈까스)", price: 5000)
        ]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        configureHeader()
    }


}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let index = FoodType.allCases[section]
        guard let count = menu[index]?.count else { return 0}
        return count
    }
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
      
        let index = FoodType.allCases[indexPath.section]
        guard let name = menu[index] else { return UITableViewCell() }
        cell.menuLabel.text = name[indexPath.row].name
        cell.circleImage.image = UIImage(systemName: "circle")
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionTitle = FoodType.allCases[section].rawValue
        return sectionTitle
    }
    
    func configureHeader() {
        let header = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 30))
      
        header.text = "메뉴판"
        header.textAlignment = .center
        header.font = UIFont.systemFont(ofSize: 30)
        tableView.tableHeaderView = header
    }
}
