//
//  Sample.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/12/18.
//

import Foundation

struct Sample {
    // MARK: Community's sample data.
    static let community1: Community = .init(name: "Life is Tech!", imagePath: "")
    static let community2: Community = .init(name: "Tokyo City Univercity", imagePath: "")
    static let community3: Community = .init(name: "Gast", imagePath: "")
    static let communities = [community1, community2, community3]
    
    // MARK: Member's sampledata.
    static let member1 = Member(communityID: community1.id, name: "Urassh" , realName: "Shuto Urayama"   , imagePath: "image", gradation: "GradationColor_A", friendship: Member.Friendship(0.8), about: "")
    static let member2 = Member(communityID: community1.id, name: "Minorin", realName: "Minori Murakami" , imagePath: "image", gradation: "GradationColor_B", friendship: Member.Friendship(1.0), about: "")
    static let member3 = Member(communityID: community1.id, name: "Wally"  , realName: "Hiroyuki Tanaka" , imagePath: "image", gradation: "GradationColor_C", friendship: Member.Friendship(0.7), about: "")
    static let member4 = Member(communityID: community2.id, name: "Shuto"  , realName: "Shuto Urayama" , imagePath: "image", gradation: "GradationColor_A", friendship: Member.Friendship(0.8), about: "")
    static let member5 = Member(communityID: community2.id, name: "Yuki"   , realName: "Yuki Ukawa"    , imagePath: "image", gradation: "GradationColor_B", friendship: Member.Friendship(1.0), about: "")
    static let member6 = Member(communityID: community2.id, name: "mahiro" , realName: "Mahiro Adati"  , imagePath: "image", gradation: "GradationColor_C", friendship: Member.Friendship(0.7), about: "")
    static let members = [member1, member2, member3, member4, member5, member6]
}
