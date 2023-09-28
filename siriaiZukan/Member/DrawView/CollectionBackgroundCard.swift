//
//  CollectionBackgroundCard.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/09/22.
//

import Foundation
import UIKit
 
class DrawView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.clear;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let rectangle = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 80, height: 140), cornerRadius: 5)
        
        UIColor(red: 1, green: 0.5, blue: 0, alpha: 0.3).setFill()
        UIColor(red: 1, green: 1, blue: 1, alpha: 0.5).setStroke()
        rectangle.lineWidth = 6.0
        
        rectangle.fill()
        rectangle.stroke()
        
    }
 
}
