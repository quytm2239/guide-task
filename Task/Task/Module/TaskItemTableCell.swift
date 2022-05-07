//
//  TaskItemTableCell.swift
//  Task
//
//  Created by Tran Manh Quy on 02/05/2022.
//

import UIKit

class TaskItemTableCell: UITableViewCell {
    @IBOutlet weak var labelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
