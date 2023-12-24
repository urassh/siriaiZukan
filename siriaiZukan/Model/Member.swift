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
    
    static func newMember(communityID: Community.ID) -> Member {
        .init(communityID: communityID, name: "unknown", realName: "unknown", imagePath: "person.fill", gradation: "GradationColor_A", friendship: .init(0.0), about: "この人物について書きましょう！")
    }
    
    struct ID: Hashable {
        var uuid: UUID
        init(uuid: UUID = UUID()) {
            self.uuid = uuid
        }
    }
    
    struct Friendship {
        public static let MAXIMUM: CGFloat = 1.0
        public static let MINIMUM: CGFloat = 0.0
        
        private let parameter: CGFloat
        
        init(_ parameter: CGFloat) {
            self.parameter = parameter
        }
        
        public func setParameter(_ parameter: CGFloat) -> Friendship {
            Friendship(parameter)
        }
        
        public func getParameter() -> CGFloat {
            self.parameter
        }
        
        private static func validation(_ value: CGFloat) {
            let safetyValue: Bool = (0.0 <= value) && (value <= 1.0)
            guard safetyValue else { fatalError("friendshipParameterの値が不正です。") }
        }
    }
}
