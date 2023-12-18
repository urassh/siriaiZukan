//
//  Community.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/11/09.
//

import Foundation

struct Community: Identifiable {
    let id: ID = ID()
    var name: String
    var imagePath: String
    
    struct ID: Hashable {
        var uuid: UUID
        init(uuid: UUID = UUID()) {
            self.uuid = uuid
        }
    }
}
