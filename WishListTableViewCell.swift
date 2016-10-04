//
//  WishListTableViewCell.swift
//  BanDiary
//
//  Created by ZhaoYanfei on 9/12/16.
//  Copyright © 2016 FayeZhao. All rights reserved.
//

import UIKit

class WishListTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var bandImage: UIImageView!
    
    @IBOutlet weak var bandName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
