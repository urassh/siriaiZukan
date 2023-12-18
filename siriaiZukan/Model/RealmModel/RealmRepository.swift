//
//  RealmRepository.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/11/21.
//

import Foundation
import RealmSwift

class RealmRepository<T: RealmData> {
    private let realm = try! Realm()
    
    func append(newData: T) {
        try! realm.write {
            realm.add(newData)
        }
    }
    
    func update(before: T, newData: T) {}
    
    func delete(data: T) {
        try! realm.write {
            realm.delete(data)
        }
    }
    
    func getAlldata() -> [T] {
        return Array(realm.objects(T.self))
    }
}
