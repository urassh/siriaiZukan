//
//  DatabaseProtocol.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/12/18.
//

import Foundation
import Combine

protocol DatabaseProtocol {
    associatedtype Entity
    static func entities() -> AnyPublisher<[Entity], Error>
    static func postEntity(_ enetity: Entity, completion: @escaping (Result<Void, Error>) -> Void)
}
