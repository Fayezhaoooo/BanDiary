//
//  CancelationTableViewCell.swift
//  BanDiary
//
//  Created by ZhaoYanfei on 9/21/16.
//  Copyright © 2016 FayeZhao. All rights reserved.
//

import UIKit

class CancelationTableViewCell: UITableViewCell {
    @IBOutlet weak var bandImage: UIImageView!
    @IBOutlet weak var bandName: UILabel!
    @IBOutlet weak var reasonToCancel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
