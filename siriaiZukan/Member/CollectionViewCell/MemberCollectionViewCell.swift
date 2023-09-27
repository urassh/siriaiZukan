//
//  MemberCollectionViewCell.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/09/22.
//

import UIKit

class MemberCollectionViewCell: UICollectionViewCell {
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var nickNameLabel: UILabel!
    @IBOutlet var realNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImage.layer.borderWidth  = 2.0
        iconImage.layer.borderColor  = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6).cgColor
        iconImage.layer.cornerRadius = 25
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupBackgroundView()
    }
    
    public func setupInfo(icon: UIImage, nickName: String, realName: String) {
        iconImage.image    = icon
        nickNameLabel.text = nickName
        realNameLabel.text = realName
    }
    
    private func setupBackgroundView() {
        let drawView = DrawView(frame: self.bounds)
        self.backgroundView = drawView
    }
    

}
