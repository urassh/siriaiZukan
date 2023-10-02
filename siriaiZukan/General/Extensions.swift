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
        let aspectWidth = newSize.width / size.width
        let aspectHeight = newSize.height / size.height
        let scaleFactor = max(aspectWidth, aspectHeight)

        let scaledSize = CGSize(width: size.width * scaleFactor, height: size.height * scaleFactor)

        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)

        let x = (scaledSize.width - newSize.width) / 2.0
        let y = (scaledSize.height - newSize.height) / 2.0
        let rect = CGRect(x: -x, y: -y, width: scaledSize.width, height: scaledSize.height)

        self.draw(in: rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage ?? self
    }
}
