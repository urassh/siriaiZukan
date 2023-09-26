//
//  Extensions.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/09/21.
//

import Foundation
import UIKit

extension UIImage {
    func roundedCorners(radius: CGFloat) -> UIImage {
        return UIGraphicsImageRenderer(size: self.size).image { context in
            let rect = context.format.bounds
            let roundedPath = UIBezierPath(roundedRect: rect,
                                           cornerRadius: radius)
            roundedPath.addClip()
            draw(in: rect)
        }
    }

    func resizable(toSize newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        self.draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? self
    }
}
