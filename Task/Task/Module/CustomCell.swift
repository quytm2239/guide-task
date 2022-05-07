//
//  CustomCell.swift
//  Task
//
//  Created by Tran Manh Quy on 07/05/2022.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var imgViewThumbnail: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
