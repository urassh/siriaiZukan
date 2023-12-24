//
//  MemberViewModel.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/12/13.
//

import Foundation
import Combine

class MemberViewModel: ObservableObject {
    @Published var members: [Member] = []
    @Published var showDetailView: Bool = false
    @Published var showEditView: Bool = false
    @Published var selectMember: Member?
    @Published var hasWriteError: Bool = false
    private var isActivate: Bool = false
    private var cancellable: Set<AnyCancellable> = []
    let community: Community
    
    init(community: Community) {
        self.community = community
    }
    
    func appendCommunity(_ member: Member, completion: @escaping (Result<Void, Error>) -> Void) {
        MemberDatabase.postEntity(member) { [weak self] result in
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
    
    func activate() {
        if isActivate { return }
        isActivate = true
        
        print("viewModel is disappeared")
        
        MemberDatabase.entities().sink(receiveCompletion: { _ in
            //TODO
        }, receiveValue: { [weak self] members in
            guard let self = self else { return }
            
            self.members = members.filter {
                $0.communityID == self.community.id
            }
        })
        .store(in: &cancellable)
    }
    
    func deactivate() {
        guard isActivate else { return }
        print("viewModel is disappeared")
        cancellable.removeAll()
    }
}
