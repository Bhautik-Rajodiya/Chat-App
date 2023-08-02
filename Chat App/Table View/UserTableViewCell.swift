//
//  UserTableViewCell.swift
//  Chat App
//
//  Created by Bhautik Rajodiya on 26/07/23.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
