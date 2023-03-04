//
//  ViewController.swift
//  JSONTable
//
//  Created by Harry on 2023/03/04.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var items: Items = []
    var sevenKi: Items = []
    var eightKi: Items = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        decodeJSON()
        setNumberOfRowsInCardinal()
    }
    
    func setNumberOfRowsInCardinal() {
        items.forEach { item in
            if item.cardinalNumber == "7" {
                sevenKi.append(item)
            } else { eightKi.append(item) }
        }
    }

    func decodeJSON() {
        let decoder = JSONDecoder()
        
        guard let dataSet = NSDataAsset(name: "phone") else { return }
        
        do {
            items = try decoder.decode(Items.self, from: dataSet.data)
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return sevenKi.count
        }
        
        return eightKi.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "7기"
        }
        
        return "8기"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? MyTableViewCell else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            let content = sevenKi[indexPath.row]
            cell.backgroundColor = .orange
            cell.nameLabel.text = content.name
            cell.numberLabel.text = "\(content.cardinalNumber)기"
            cell.modelLabel.text = content.model
            
            return cell
        }
        
        let content = eightKi[indexPath.row]
        cell.backgroundColor = .cyan
        cell.nameLabel.text = content.name
        cell.numberLabel.text = "\(content.cardinalNumber)기"
        cell.modelLabel.text = content.model
        
        return cell
    }
}

