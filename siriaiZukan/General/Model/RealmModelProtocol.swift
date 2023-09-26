//
//  RealmModelProtocol.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/09/20.
//

import Foundation
import Realm
import UIKit

protocol RealmModel: Sequence, RealmSwiftObject {
    var name: String { set get }
    var image: String { set get }
}
