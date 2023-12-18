//
//  GradationColor_C.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/11/12.
//
import SwiftUI

struct GradationColor_C: GradationColor {
    var colors: [Color] = [Color(.sRGB, red: 1, green: 26 / 255, blue: 34 / 255, opacity: 1), Color(.sRGB, red: 1, green: 190 / 255, blue: 0, opacity: 1)]
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
