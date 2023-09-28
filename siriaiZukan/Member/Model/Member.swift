//
//  Member.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/09/22.
//
import Foundation
import RealmSwift

class Member: Object, RealmModel, Sequence {
    @Persisted var id: String = UUID().uuidString
    @Persisted var name: String
    @Persisted var nickName: String
    @Persisted var image: String
    @Persisted var about: String
    @Persisted var communityID: String

    // RealmSwiftのListを使用して要素を格納
    var elements: List<Member> = List<Member>()

    // Sequenceプロトコルに必要な要素を提供するメソッド
    func makeIterator() -> some IteratorProtocol {
        return elements.makeIterator()
    }
}
