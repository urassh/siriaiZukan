//
//  MemberRepository.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/11/21.
//

import Foundation
import RealmSwift

class MemberRepository: RealmRepository<Member> {
    private let realm = try! Realm()
    
    override func update(before: Member, newData: Member) {
        try! realm.write {
            before.name       = newData.name
            before.realName   = newData.realName
            before.imagePath  = newData.imagePath
            before.gradation  = newData.gradation
            before.friendship = newData.friendship
        }
    }
}
