//
//  ViewController.swift
//  JSonTraining
//
//  Created by kimseongjun on 2023/03/04.
//

import UIKit

class ViewController: UIViewController {
    
    var decodedCampers: CampersDecoder = CampersDecoder()
    
    private var tableListView: UITableView = {
        let tableView = UITableView()
        tableView.register(TableListViewCell.self , forCellReuseIdentifier: "cell")
        
        tableView.backgroundColor = .blue
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableListView.dataSource = self
        configureUI()
        checkValidDecodedData()
        print(decodedCampers.campers.count)
        
    }
    
    func checkValidDecodedData() {
        do {
            try decodedCampers.decodeData()
        } catch {
            print("에러 발생")
        }
    }
    
    func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(tableListView)
        
        NSLayoutConstraint.activate([
            tableListView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableListView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableListView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableListView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
}

extension ViewController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return decodedCampers.campers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableListView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableListViewCell else { return UITableViewCell() }
        cell.receiveData(campers: decodedCampers.campers[indexPath.row])
        return cell
    }
}

class TableListViewCell: UITableViewCell {
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var gisuLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func receiveData(campers: Campers) {
        nameLabel.text = "이름: " + campers.name
        gisuLabel.text = "기수: " + campers.gisu.description
        phoneNumberLabel.text = "번호: " + campers.phoneNumber
    }
    
    func configureUI() {
        self.addSubview(nameLabel)
        self.addSubview(gisuLabel)
        self.addSubview(phoneNumberLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
         
            gisuLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            gisuLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 20),
            
            phoneNumberLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: gisuLabel.trailingAnchor, constant: 20),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20)
            
        ])
    }
}
