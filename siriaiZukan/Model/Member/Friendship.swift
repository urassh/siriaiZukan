//
//  Friendship.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/11/15.
//

import Foundation

struct Friendship {
    public static let MAXIMUM: Float = 1.0
    public static let MINIMUM: Float = 0.0
    
    private let parameter: Float
    
    init(_ parameter: Float) {
        Friendship.validation(parameter)
        self.parameter = parameter
    }
    
    public func setParameter(_ parameter: Float) -> Friendship {
        Friendship(parameter)
    }
    
    public func getParameter() -> Float {
        self.parameter
    }
    
    private static func validation(_ value: Float) {
        let safetyValue: Bool = (0.0 <= value) && (value <= 1.0)
        guard safetyValue else { fatalError("friendshipParameterの値が不正です。") }
    }
}
