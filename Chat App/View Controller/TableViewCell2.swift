//
//  TableViewCell2.swift
//  Chat App
//
//  Created by Bhautik Rajodiya on 17/08/23.
//

import UIKit

class TableViewCell2: UITableViewCell {

    
    @IBOutlet weak var lable2: UILabel!
    @IBOutlet weak var dateLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
