//
//  Community.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/09/20.
//
import Foundation
import RealmSwift
import UIKit

class Community: Object, RealmModel, Sequence {
    @Persisted var id: String = UUID().uuidString
    @Persisted var name: String
    @Persisted var image: String
    
    // RealmSwiftのListを使用して要素を格納
    var elements: List<Community> = List<Community>()
    
    // Sequenceプロトコルに必要な要素を提供するメソッド
    func makeIterator() -> some IteratorProtocol {
        return elements.makeIterator()
    }
}
