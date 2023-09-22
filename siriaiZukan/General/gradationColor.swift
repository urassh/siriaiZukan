//
//  gradationColor.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/09/22.
//

import UIKit
import RealmSwift

enum GradientStyle {
    case purple
    case blue
    case green
    case pink
    case orange
    
    func createGradientLayer(frame: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint   = CGPoint(x: 1.0, y: 0.5)
        
        switch self {
        case .purple:
            gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        case .blue:
            gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        case .green:
            gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        case .pink:
            gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        case .orange:
            gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        }
        
        return gradientLayer
    }
}
