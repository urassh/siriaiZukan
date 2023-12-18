//
//  GradationColor_D.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/11/12.
//

import SwiftUI

struct GradationColor_D: GradationColor {
    var colors: [Color] = [Color(.sRGB, red: 74 / 255, green: 255 / 255, blue: 197 / 255, opacity: 1), Color(.sRGB, red: 56 / 255, green: 130 / 255, blue: 250 / 255, opacity: 1)]
    var startPoint: UnitPoint = UnitPoint(x: 0, y: 1)
    var endPoint: UnitPoint   = UnitPoint(x: 1, y: 0)
    
    func getColor() -> LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: colors),
            startPoint: startPoint,
            endPoint:   endPoint
        )
    }
}
