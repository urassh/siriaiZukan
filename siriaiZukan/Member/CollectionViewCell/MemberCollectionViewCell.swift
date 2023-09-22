//
//  MemberCollectionViewCell.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/09/22.
//

import UIKit

class MemberCollectionViewCell: UICollectionViewCell {

    @IBOutlet var icon: UIImageView!
    @IBOutlet var nickName: UILabel!
    @IBOutlet var realName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        icon.image = UIImage(systemName: "person.fill")?.roundedCorners(radius: 25)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupBackgroundView()
    }
        
    private func setupBackgroundView() {
        let drawView = DrawView(frame: self.bounds)
        self.backgroundView = drawView
    }

}
