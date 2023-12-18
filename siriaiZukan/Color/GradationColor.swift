//
//  GradationColor.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/11/12.
//

import Foundation
import SwiftUI

class GradationColor {
    var colors: [Color] {
        [Color(.sRGB, red: 225 / 255, green: 0 / 255, blue: 203 / 255, opacity: 1), Color(.sRGB, red: 250 / 255, green: 232 / 255, blue: 56 / 255, opacity: 1)]
    }
    var startPoint: UnitPoint {
        UnitPoint(x: 0, y: 1)
    }
    var endPoint:   UnitPoint {
        UnitPoint(x: 1, y: 0)
    }
    
    func getColor() -> LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: colors),
            startPoint: startPoint,
            endPoint:   endPoint
        )
    }
    
    static let colorA = GradationColor_A()
}
