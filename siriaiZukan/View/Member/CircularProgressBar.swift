//
//  CircularProgressBar.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/11/15.
//

import SwiftUI

struct CircularProgressBar: View {
    let parameter: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 6.0)
                .opacity(0.3)
                .foregroundColor(.green)
                .frame(width: 150, height: 150)
            Circle()
                .trim(from: 0.0, to: min(parameter, 1.0))
                .stroke(style: StrokeStyle(lineWidth: 8.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(.green)
                .frame(width: 150, height: 150)
                .rotationEffect(Angle(degrees: 270.0))
        }
    }
}
