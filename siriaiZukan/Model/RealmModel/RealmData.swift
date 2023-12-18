//
//  RealmData.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/11/21.
//

import Foundation
import RealmSwift

class RealmData: Object, Identifiable {
    @Persisted var id: UUID
    @Persisted var name: String
    @Persisted var imagePath: String
}
