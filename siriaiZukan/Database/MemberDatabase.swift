//
//  MemberDatabase.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/12/18.
//

import Foundation
import Combine

struct MemberDatabase: DatabaseProtocol {
    private static let _memberSubject: CurrentValueSubject<[Member], Error> = .init(Sample.members)
    
    static func entities() -> AnyPublisher<[Member], Error> {
        return _memberSubject.eraseToAnyPublisher()
    }
    
    static func postEntity(_ enetity: Member, completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if Bool.random() {
                _memberSubject.value.append(enetity)
                completion(.success(()))
            } else {
                completion(.failure(DummyError()))
            }
        }
    }
}
