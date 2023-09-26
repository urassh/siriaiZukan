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
        iconImage.image = UIImage(systemName: "person.fill")?.roundedCorners(radius: 25)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupBackgroundView()
    }
    
    public func setupInfo(icon: UIImage, nickName: String, realName: String) {
        iconImage.image    = icon.roundedCorners(radius: 25)
        nickNameLabel.text = nickName
        realNameLabel.text = realName
    }
    
    private func setupBackgroundView() {
        let drawView = DrawView(frame: self.bounds)
        self.backgroundView = drawView
    }
    

}
