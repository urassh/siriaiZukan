//
//  RealmRepository.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/09/20.
//

import RealmSwift

class RealmRepository<T: RealmModel> {
    private let realm: Realm
    
    init() {
        realm = try! Realm()
    }
    
    func append(_ instance: T) {
        try! realm.write {
            realm.add(instance)
        }
    }
    
    func update(before: T, after: T) {
        delete(before)
        append(after)
    }
    
    func delete(_ instance: T) {
        try! realm.write {
            realm.delete(instance)
        }
    }
    
    func getAllitems() -> Array<T> {
        return Array(realm.objects(T.self))
    }
}
