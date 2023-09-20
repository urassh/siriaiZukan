//
//  CommunityTableViewCell.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/09/20.
//

import UIKit

class CommunityTableViewCell: UITableViewCell {
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func setInfo(name: String, image: UIImage) {
        nameLabel.text  = name
        iconImage.image = image
    }
}
