//
//  FoodEntryCell.swift
//  FoodTable
//
//  Created by Harry on 2023/02/25.
//

import UIKit

class FoodEntryCell: UITableViewCell {

    @IBOutlet weak var fooNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
