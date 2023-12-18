//
//  CommunityDatabase.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/12/18.
//

import Foundation
import Combine

public enum CommunityDatabase: DatabaseProtocol {
    private static let _communitySubject: CurrentValueSubject<[Community], Error> = .init(Sample.communities)
    
    static func entities() -> AnyPublisher<[Community], Error> {
        return _communitySubject.eraseToAnyPublisher()
    }
    
    static func postEntity(_ enetity: Community, completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if Bool.random() {
                _communitySubject.value.append(enetity)
                completion(.success(()))
            } else {
                completion(.failure(DummyError()))
            }
        }
    }
}

struct DummyError: Error {
    
}
