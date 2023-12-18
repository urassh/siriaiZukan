//
//  ExtendTransition.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/12/18.
//

import Foundation
import SwiftUI

extension AnyTransition {
    static func cardTransition() -> AnyTransition {
        AnyTransition.asymmetric(
            insertion: AnyTransition.opacity.combined(with: .offset(x: 100, y: 50)),
            removal  : AnyTransition.opacity.combined(with: .offset(x: -100, y: -50))
        )
    }
}
