//
//  Community.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/11/09.
//

import Foundation
import RealmSwift

class Community: RealmData {
    convenience init(id: UUID = UUID(), name: String, imagePath: String) {
        self.init()
        //主キー
        self.id = id
        
        self.name = name
        self.imagePath = imagePath
    }
    
    static let sample1 = Community(name: "Sample Community", imagePath: "")
}
