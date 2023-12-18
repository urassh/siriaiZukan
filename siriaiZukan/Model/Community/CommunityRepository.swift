//
//  CommunityRepository.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/11/21.
//

import Foundation
import RealmSwift

class CommunityRepository: RealmRepository<Community> {
    private let realm = try! Realm()
    
    override func update(before: Community, newData: Community) {
        try! realm.write {
            before.name       = newData.name
            before.imagePath  = newData.imagePath
        }
    }
}
