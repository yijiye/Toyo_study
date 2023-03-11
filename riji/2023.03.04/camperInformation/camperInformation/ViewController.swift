//
//  ViewController.swift
//  camperInformation
//
//  Created by jiye Yi on 2023/03/04.
//

import UIKit

class CamperInfoViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var camperInfo: [Information] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        decodeData()
        configureHeader()
    }
    
    private func decodeData() {
        let jsonDecoder = JSONDecoder()
        guard let information: NSDataAsset = NSDataAsset(name: "camper") else { return }
        do {
            self.camperInfo = try jsonDecoder.decode([Information].self, from: information.data)
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension CamperInfoViewController: UITableViewDataSource {
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return camperInfo.count
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }

        
       cell.nameLabel.text = "\(camperInfo[indexPath.row].name)"
       cell.generationLabel.text = "\(camperInfo[indexPath.row].generation) 기"
       cell.phoneLabel.text = "\(camperInfo[indexPath.row].phone)"
        
        return cell
    }
    
    
    func configureHeader() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        headerView.backgroundColor = .systemGray6
        let headerLabel = UILabel()
        headerLabel.text = "토요스터디 B조 캠퍼"
        headerLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        headerLabel.sizeToFit()
        headerLabel.center = headerView.center
        headerView.addSubview(headerLabel)
        tableView.tableHeaderView = headerView
    }

}

extension CamperInfoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showAlert(indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func showAlert(indexPath: IndexPath) {
        let message = "\(camperInfo[indexPath.row].generation)기"
        let alert = UIAlertController(title: "정보", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "오키", style: .cancel))
        present(alert, animated: true)
    }
}

