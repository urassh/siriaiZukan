//
//  CommunityViewModel.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/12/18.
//

import Foundation
import Combine

class CommunityViewModel<CommunityDatabase: DatabaseProtocol>: ObservableObject {
    @Published var communities: [Community] = []
    @Published var hasWriteError: Bool = false
    private var isActivate: Bool = false
    private var cancellable: Set<AnyCancellable> = []
    
    func appendCommunity(_ community: Community, completion: @escaping (Result<Void, Error>) -> Void) {
        CommunityDatabase.postEntity(community as! CommunityDatabase.Entity) { [weak self] result in
            guard let self = self else { return }
            
            do {
                try result.get()
                hasWriteError = false
            } catch {
                hasWriteError = true
            }
            
            completion(result)
        }
    }
    
}
