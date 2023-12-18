//
//  Member.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/11/09.
//

import Foundation

struct Member: Identifiable {
    let id: ID = ID()
    let communityID: Community.ID
    var name: String
    var realName: String
    var imagePath: String
    var gradation: String
    var friendship: Friendship
    var about: String
    
    struct ID: Hashable {
        var uuid: UUID
        init(uuid: UUID = UUID()) {
            self.uuid = uuid
        }
    }
    
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
}
