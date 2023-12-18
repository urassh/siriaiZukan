//
//  Member.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/11/09.
//

import Foundation
import RealmSwift

class Member: RealmData {
    @Persisted var communityID: UUID
    @Persisted var realName: String
    @Persisted var gradation: String
    @Persisted var friendship: Float
    @Persisted var about: String
    
    convenience init(id: UUID = UUID(), name: String, realName: String, imagePath: String, gradation: String, communityID: UUID, friendship: CGFloat, about: String) {
        self.init()
        //主キー / 外部キー
        self.id          = id
        self.communityID = communityID
        
        self.name        = name
        self.realName    = realName
        self.imagePath   = imagePath
        self.gradation   = gradation
        self.friendship  = Float(friendship)
        self.about       = about
    }
    
    static let sample1 = Member(name: "Urassh" , realName: "Shuto Urayama"   , imagePath: "image", gradation: "GradationColor_A", communityID: UUID(), friendship: 0.8, about: "")
    static let sample2 = Member(name: "Minorin", realName: "Minori Murakami" , imagePath: "image", gradation: "GradationColor_B", communityID: UUID(), friendship: 1.0, about: "")
    static let sample3 = Member(name: "Wally"  , realName: "Hiroyuki Tanaka" , imagePath: "image", gradation: "GradationColor_C", communityID: UUID(), friendship: 0.6, about: "")
}
